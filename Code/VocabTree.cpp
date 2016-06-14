#include "stdafx.h"

/* TODO:

* Entropy of feature
* Feature source images
*/

#include <iostream>
#include <algorithm>
#include <vector>
#include <list>
#include <stdio.h>
#include <stdlib.h>
#include "stdio.h"
#include <time.h>
#include <math.h>
#include "Defines.h"
#include "FeatureOps.h"
#include "FileIO.h"
#include "KMeans.h"

#include <vector>

#define MAXDEPTH 6

using namespace std;

#define NUM_FEATURES_FOR_TREE		400000

FILE * fd1;
ImageList imageList;
TreeNode *root;
int i;
int numObjects = 20;
int dataSize = numObjects * 18;
int fdiv = 0, fileNameNum = 1;
char buf[256];
vector<DescStruct> descs;	
DescStruct tempDS;
double sum;
string filename;

bool compareDescStructs(DescStruct a, DescStruct b)
{
	return a.entropy < b.entropy;
}

void fprintfNode(TreeNode * node)
{
	int i, j;
	
	if (node->children[0] != NULL)
	{
		fprintf(fd1, "nodeCenters{pos} = [\n");
		for (i = 0; i < 8; i++)
		{
			for (j = 0; j < 128; j++)
			{
				fprintf(fd1, "%f ", node->centres[i][j]);
			}
			fprintf(fd1, ";\n");
		}
		fprintf(fd1, "];\n");

		fprintf(fd1, "children_ids{pos} = [");
		for (i = 0; i < 8; i++)
		{
			fprintf(fd1, "%d ", (int)(node->children[i]));
		}
		fprintf(fd1, "];\n");
	}

	fprintf(fd1, "ids(pos) = %d;\n", (int)node);

 	fprintf(fd1, "invFile{pos} = [");
	for (i = 0; i < node->invFile.size(); i++)
	{
		fprintf(fd1, "   %d %e\n", node->invFile[i].imageId, node->invFile[i].nodeCount2);
	}
	fprintf(fd1, "];\npos = pos + 1;\n");

	fdiv++;
	if (fdiv > 500)
	{
		fclose(fd1);
		fdiv = 0;

		sprintf(buf, "fileout%d.m", fileNameNum++);

		fd1 = fopen(buf, "w");
	}

	for (i = 0; i < 8; i++)
	{
		if (node->children[i] != NULL)
			fprintfNode(node->children[i]);
	}

	
}

int _tmain(int argc, char* argv[])
{
	cout << "Loading features..." << endl;

	// Load and count features from images
	char file[200];
    char file1[200];

	unsigned int fCount = 0;
	for(int i = 1; i <= dataSize; i ++)
	{

		
		sprintf(file, "E:\\PhDWork\\code\\vocab_tree_v5\\vocab_tree\\Deon's code\\Feature Files\\%05u.dat", i);
		sprintf(file1, "E:\\PhDWork\\code\\vocab_tree_v5\\vocab_tree\\Deon's code\\Feature Files\\%05u.da2", i);
		fCount += loadFeatureList(file, file1,&imageList);
	}

	// Calculate the frame interval to limit the number of features
	int interval = fCount / NUM_FEATURES_FOR_TREE;
	if(interval == 0)
	{
		interval = 1;
	}

	// Assign features to root node
	root = new TreeNode;
	for(int j = 0; j < imageList.size(); j += interval)
	{
		cout << ".";
		for(int i = 0; i < imageList[j]->N; i++)
		{
			root->descList.push_back(&(imageList[j]->d[i]));
		}
	}
	cout << endl;
	
	 

	clusterNode(root, 0, MAXDEPTH - 1);

	saveTree("35Objects.tree", root);

	// Load the stored tree from the disk
	root = loadTree("35Objects.tree");	

	// Create the inverted files for each of the nodes
	populateInvertedFiles(root, &imageList);	
	
	// Calculate the node entropy
	calcEntropy(root, imageList.size());

	// Normalise the document vectors
	normaliseVectors(root, imageList.size());

	saveTree("35Objects-Entropy.tree", root);

//	cout << "Choose image number for similarity calculation: " << endl;

	// Calculate the similarity vector for image 1
	cout << "Calculating similarity..." << endl;

	FILE *fd = fopen("simresult.txt", "w");

	for(int i = 0; i < imageList.size(); i++)
	{
		cout << "Processing image " << i << " of " << imageList.size() << endl;
		double *sim = calcSimilarity(root, i, imageList.size());
		for(int j = 0; j < imageList.size(); j++)
		{
			fprintf(fd, "%1.3f ", sim[j]);
		}
		fprintf(fd, "\n");
	}

	fclose(fd);

		printf("\n");
    
    char filename[100];

	/*char * names[] = {"allBran","curry1", "curry2", "elephant", "salad"};*/

	char * names[] = {"allBran","battery","can1","can2","curry1", "curry2", "elephant", 
		"handbag","jbox1","jbox2","lemonbottle",
		"mrMin","salad","sauce1","sauce2","spice1", "spice2",
		"sprayCan1","sprayCan2","sprayCan"};
	/*char * names[] = {"allBran","battery","can1","can2","curry1", "curry2", "elephant", 
		"fisherprice","handbag3","handbag"};	*/
	char * sub[] = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r"};

//	double *sim = calcSimilarity(root, 20, imageList.size());

	// Output similarity to screen
//	for(int i = 0; i < imageList.size(); i++)
//	{
//		cout << imageList[i]->filename << " : " << sim[i] << endl;
//	}
// Calculate total entropy for every viewpoint
	int count = 0; //need count because the images are stored sequentally -so object 2 starts at 19
	for (int ii=0; ii < numObjects; ii++) //no of objects
	{
	  for(int m = 0;m<18;m++)//no of views
//		for(int m = (ii * 18);m<((ii+1) * 18);m++)
		{ 
			 sum = 0;

			 sprintf( filename, "%s_%s.m",names[ii], sub[m]);
			 printf("%s\n", filename);

			 fd1= fopen(filename, "w");
	      
			 for (i = 0; i < imageList[count]->N; i++)
			{
			//printf("Entropy of feature %d is %f\n", i, 
				imageList[count]->entropyValues[i] = parseFeatureForEntropy(root, imageList[count]->d[i]);
				sum = sum + imageList[count]->entropyValues[i];
			}

			 descs.clear();

			for (i = 0; i < imageList[count]->N; i++)
		   {
	    		tempDS.entropy = imageList[count]->entropyValues[i];
				memcpy((char *)tempDS.value, (char *)(imageList[count]->d[i]), sizeof(unsigned char) * 128);		
				memcpy((char *)tempDS.frame, (char *)(imageList[count]->frame[i]), sizeof(double) * 4);

			   descs.push_back(tempDS);
			}
			//sorts the entropy values of the features and keeps track of frames and descriptors
			std::sort(descs.begin(), descs.end(), compareDescStructs);

		   
           // fprintf(fd1,"D =[\n");
			 //want to add all the entropy values for this viewpoint
			//for(int j=imageList[count]->N-1; j>=(imageList[count]->N-20); j--)
		/*	for(int j=0; j<imageList[count]->N; j++)
			{			
				//sum = sum + imageList[count]->entropyValues[j];
			   fprintf(fd1,"%e;\n",descs[j].entropy);//imageList[145]->entropyValues[j]);	
			   fflush(fd1);
			
			}
			
			fprintf(fd1,"\n");
			fprintf(fd1, "];\n");
			fprintf(fd1,"E =[\n");
		    
			for(int n=0; n<imageList[count]->N;n++)
     		
			{		
			 
			   for(int k =0;k<4;k++)
	    		{
					fprintf(fd1,"%e ",descs[n].frame[k]);
					cout<<descs[n].frame[k];
						 
				  }
			   fprintf(fd1,";\n");
			   fflush(fd1);
			 }*/

			//fprintf(fd1, "];\n");
            fprintf(fd1,"%e",sum);
		    fclose(fd1);
	        count = count + 1;		
		  }
	
	  }	
	  cout<<"the value of count is"<<endl;
	  cout<<count<<endl;
			
     		//fprintf(fd1,"D =[\n");
			//for(int j=imageList[145]->N-1; j>(imageList[145]->N)-11;j--)
		
			//for(int j=1; j<imageList[count]->N; j++)
			//{			
			// fprintf(fd1,"%e;\n",descs[j].entropy);//imageList[145]->entropyValues[j]);	
			// fflush(fd1);
			//   cout<<descs[j].entropy;
			 //sum = sum + descs[j].entropy;
			  // cout<<"sum";
			   //count<<sum;
			//}
			//fprintf(fd1, "%e;", sum);
			//fprintf(fd1,"\n");
			//fprintf(fd1, "];\n");

		  /* fprintf(fd1,"E =[\n");
		   //for(int j=imageList[145]->N-1; j>(imageList[145]->N)-11;j--)
		  for(int j=0; j<20;j++)
			 //for(int j=0; j < 10; j++)
			{		
			   for(int k =0;k<4;k++)
	    		{
		    		fprintf(fd1,"%e ",imageList[145]->frame[j][k]);
					//descs[j].frame[k]);//);;		 
				  }
			   fprintf(fd1,";\n");
			 }

			fprintf(fd1, "];\n");*/

			/*fprintf(fd1,"F=[\n");
			//for(int j=imageList[145]->N-1; j>(imageList[145]->N)-11;j--)
			for(int j=0; j < 15; j++)
			{	
				for(int k =0;k<128;k++)
	        		{ fprintf(fd1,"%u ", descs[j].value[k]);//imageList[145]->d[j][k]);	
			  
					}
				fprintf(fd1,";\n");
			 }

			 fprintf(fd1, "];\n");*/
			//fclose(fd1);
			
		//}
		//count = count + 1;
//	}	



	// Generate fileout files containing tree.

	fd1 = fopen("fileout.m", "w");
	fprintf(fd1, "invFile = {}; pos=1;\n");
	fprintf(fd1, "nodeCenters = {};\n");
	fprintf(fd1, "children_ids = {};\n");
	fprintf(fd1, "ids = [];\n");

	fprintfNode(root);
    
	fclose(fd1);

	system("pause");

	return 0;
}


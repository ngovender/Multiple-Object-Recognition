#ifndef __FILEIO_H
#define __FILEIO_H

#include "Defines.h"

int loadFeatureList(const char *filename,const char *filename1, ImageList *imageList);
void saveTree(const char *filename, TreeNode *root);
TreeNode *loadTree(const char *filename);

#endif 
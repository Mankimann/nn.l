#define NOB_IMPLEMENTATION
#include "thirdparty/nob.h"
#include <stdio.h>
#include <stdbool.h>


void createFolder()
{
  
}    

bool compile(const char *path, const char *filename) {

  Nob_Cmd cmd = {0};

  
  if (!nob_file_exists(filename)) {
    fprintf(stderr, "File not exist");
    createFolder();    
  }
  else {
    fprintf(stderr, "Failed to create the file")
    }  
  cmd_append(&cmd, "");
  
  return false;
}    

int main(int argc, char *argv[])
{
  
  return 0;
}

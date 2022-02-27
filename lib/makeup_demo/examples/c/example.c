#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "codegen.h"
#include "symboltable.h"
#include "stringbuffer.h"

extern void yyerror(char* msg);

static stringBuffer* staticVariableBuffer;
static stringBuffer* classInitBuffer;
static stringBuffer* currentMethodBuffer;
static stringBuffer* finishedMethodsBuffer;
static stringBuffer* mainBuffer;

static int currentMethodBufferIndex;
static int currentMethodStackSize;
static int currentMethodStackSizeMax;
static int currentMethodNumberOfLocals;

char tempString[MAX_LENGTH_OF_COMMAND];

extern char* className;        /* from minako-syntax.y */

/* forward declarations */
static void increaseStackby(int stackdiff);
char convertType(int type);

void codegenInit() {
	staticVariableBuffer  = newStringBuffer();
	classInitBuffer       = newStringBuffer();
	currentMethodBuffer   = 0;
	finishedMethodsBuffer = newStringBuffer();
	mainBuffer            = newStringBuffer();

	stringBufferAppend(mainBuffer, "; ------- Header --------------------------------------------");
	sprintf(tempString, ".class  public synchronized %s", className);
	stringBufferAppend(mainBuffer, tempString);
	stringBufferAppend(mainBuffer, ".super  java/lang/Object");
	stringBufferAppend(mainBuffer, "; -----------------------------------------------------------");
	stringBufferAppend(mainBuffer, "");

	stringBufferAppend(finishedMethodsBuffer, "; ------- Constructor ---------------------------------------");
	stringBufferAppend(finishedMethodsBuffer, ".method public <init>()V");
	stringBufferAppend(finishedMethodsBuffer, "\t.limit stack 1");
	stringBufferAppend(finishedMethodsBuffer, "\t.limit locals 1");
	stringBufferAppend(finishedMethodsBuffer, "\taload_0");
	stringBufferAppend(finishedMethodsBuffer, "\tinvokenonvirtual java/lang/Object/<init>()V");
	stringBufferAppend(finishedMethodsBuffer, "\treturn");
	stringBufferAppend(finishedMethodsBuffer, ".end method");
	stringBufferAppend(finishedMethodsBuffer, "; -----------------------------------------------------------");
	stringBufferAppend(finishedMethodsBuffer, "");

	stringBufferAppend(staticVariableBuffer, "; ------- Class Variables -----------------------------------");

	stringBufferAppend(classInitBuffer, "; ------- Class Initializer ---------------------------------");
	stringBufferAppend(classInitBuffer, ".method static <clinit>()V");
	classInitBufferIndex = classInitBuffer->numberOfNextElement;
	stringBufferAppend(classInitBuffer, "\t.limit locals 0");

}

void codegenAppendCommand(char* cmd, int stackdiff) {
	char tempString[MAX_LENGTH_OF_COMMAND];
	sprintf(tempString, "\t%s", cmd);
	if (global) stringBufferAppend(classInitBuffer, tempString);
	else stringBufferAppend(currentMethodBuffer, tempString);
	increaseStackby(stackdiff);
}

void codegenInsertCommand(int address, char* cmd, int stackdiff) {
	char tempString[MAX_LENGTH_OF_COMMAND];
	sprintf(tempString, "\t%s", cmd);
	if (global) stringBufferInsert(classInitBuffer, address, tempString);
	else stringBufferInsert(currentMethodBuffer, address, tempString);
	increaseStackby(stackdiff);
}

void codegenAppendLabel(int label) {
	char tempString[MAX_LENGTH_OF_COMMAND];
	sprintf(tempString, "Label%d:", label);
	if (global) stringBufferAppend(classInitBuffer, tempString);
	else stringBufferAppend(currentMethodBuffer, tempString);
}
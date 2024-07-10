#include<iostream>
#include<string>
#define MAXSIZE 1024
#define leafnum 28
#define hufftreenum 2*leafnum//
#define maxdouble 9999//
using namespace std;

typedef struct Treenode {
	char data;
	double weight;
	int lchild, rchild, parent;
}HuffmanTree;//哈夫曼树结点结构体

typedef struct Codenode {
	char bits[leafnum + 1];
	int start;
	char ch;
}HuffmanCode;//哈夫曼编码表结构体

HuffmanCode code[leafnum + 1];
HuffmanTree tree[hufftreenum];
char hufcode[1000];//记录输入字符串的哈夫曼编码
char transcode[1000];

//定义全局数组存放字符名称及其对应频度
char ch[] = { '\0',' ','\n','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
float w[] = { 0,186,150,64,13,22,32,103,21,15,47,57,1,5,32,20,57,63,15,1,48,51,80,23,8,18,1,16,1 };

//建立哈夫曼树
void CreateHuffmanTree(HuffmanTree tree[]) {
	int i, j, min1index, min2index;
	double min1, min2;
	//初始化哈夫曼树结点
	for (i = 1; i <= hufftreenum; i++) {
		tree[i].data = '\0';
		tree[i].parent = 0;
		tree[i].lchild = 0;
		tree[i].rchild = 0;
		tree[i].weight = 0;
	}

	for (i = 1; i <= leafnum; i++) {//为每个叶结点赋权值和字符
		tree[i].data = ch[i];
		tree[i].weight = w[i];
	}

	for (i = leafnum + 1; i <= hufftreenum; i++) {//构造哈夫曼树
		min1index = 0;
		min2index = 0;//两个最小值
		min1 = min2 = maxdouble;//最小值索引
		for (j = 1; j < i; j++) {//从已经建立的结点里找
			if (tree[j].parent == 0) {//如果是未使用过的根节点
				if (tree[j].weight < min1) {
					min2 = min1;
					min1 = tree[j].weight;
					min2index = min1index;
					min1index = j;
				}
				else {
					if (tree[j].weight < min2) {
						min2 = tree[j].weight;
						min2index = j;
					}
				}
			}
		}
		//建立新结点
		tree[min1index].parent = i;
		tree[min2index].parent = i;
		tree[i].lchild = min1index;
		tree[i].rchild = min2index;
		tree[i].weight = tree[min1index].weight + tree[min2index].weight;
	}
	tree[hufftreenum - 1].parent = 0;
}

//建立哈夫曼编码表
void CreateCodeHuffman() {
	int i, cur, p;
	HuffmanCode buf;
	for (i = 1; i <= leafnum; i++) {
		buf.ch = ch[i];
		buf.start = leafnum;
		cur = i;
		p = tree[i].parent;
		while (p) {
			buf.start--;
			if (tree[p].lchild == cur) buf.bits[buf.start] = '0';
			else buf.bits[buf.start] = '1';
			cur = p;
			p = tree[p].parent;
		}
		code[i] = buf;
	}
}

//哈夫曼编码
void WriteHuffmanCode(char* str,HuffmanCode code[], HuffmanTree tree[]) {
	int i, j, k, n = 0;
	cout << "得到的哈夫曼编码为：" << endl;
	for (i = 0; i < strlen(str); i++) {
		for (j = 1; j <= leafnum; j++) {
			if (str[i] == tree[j].data) {
				for (k = code[j].start; k < leafnum; k++) {
					cout << code[j].bits[k];
					hufcode[n] = code[j].bits[k];
					n++;
				}
			}
		}
	}
}

//哈夫曼译码
void TransHuffmanCode(HuffmanCode code[], HuffmanTree tree[], char s[]) {
	int i;
	int n = 0;
	char* q = NULL;
	i = hufftreenum - 1;
	q = s;
	while (*q != '\0') {
		if (*q == '0') i = tree[i].lchild;
		if (*q == '1') i = tree[i].rchild;
		if (tree[i].lchild == 0 && tree[i].rchild == 0) {
			transcode[n++] = code[i].ch;
			i = hufftreenum - 1;
		}
		q++;
	}
	cout << endl;
}

//打印哈夫曼树
void PrintHuffmanTree(HuffmanTree tree[]) {
	int i;
	cout << "根据字符的使用概率所建立的哈夫曼树为:" << endl;
	cout << "字符序号   字符名称      字符频率    双亲位置    左孩子  右孩子" << endl;
	for (i = 1; i < hufftreenum; i++) {
		if (tree[i].data == '\n') {
			cout << "    " << i << "\t      " << "\\n" << "     " << '\t' << "  ";
			cout << tree[i].weight << '\t' << '\t' << tree[i].parent << '\t' << "   " << tree[i].lchild << '\t' << "   " << tree[i].rchild << endl;
		}
		else
		{
			cout << "    " << i << "\t      " << tree[i].data << '\t' << '\t' << "  ";
			cout << tree[i].weight << '\t' << '\t' << tree[i].parent << '\t' << "   " << tree[i].lchild << '\t' << "   " << tree[i].rchild << endl;
		}
	}
}

//输出每个字符的哈夫曼编码
void PrintHuffmanCode(HuffmanCode code[]) {
	int i, j;
	cout << "根据哈夫曼树对字符所建立的哈夫曼编码为:" << endl << "字符序号   字符名称   字符编码" << endl;
	for (i = 1; i <= leafnum; i++) {
		if(code[i].ch=='\n')
			cout << "   " << i << '\t' << "      " << "\\n" << "    " << '\t';
		else
		    cout << "   " << i << '\t' << "      " << code[i].ch << '\t' << '\t';
		for (j = code[i].start; j < leafnum; j++) {
			cout << code[i].bits[j];
		}
		cout << endl;
	}
}

void ShowMenu() {
	cout << " =============================================================================\n";
	cout << "||                ★★★★★★★哈夫曼编码与译码★★★★★★★  	                      ||\n";
	cout << "||============================================================================||\n";
	cout << "||============================================================================||\n";
	cout << "||                     【0】--- 退出                                          ||\n";
	cout << "||                     【1】--- 创建哈夫曼树                                  ||\n";
	cout << "||                     【2】--- 打印哈夫曼编码表                              ||\n";
	cout << "||                     【3】--- 进行哈夫曼编码                                ||\n";
	cout << "||                     【4】--- 进行哈夫曼译码                                ||\n";
	cout << "||                     【5】--- 打印哈夫曼编码文件                            ||\n";
	cout << " ==============================================================================\n";
	cout << "请输入数字来选择对应的功能：";
}

void Menu() {

	while (1)
	{
		system("cls");
		ShowMenu();
		int num;
		if (!(cin >> num))
		{
			cout << "输入格式错误！请重新输入：" << endl;
		}
		else {
			switch (num) {
				case 0:
					exit(0);
				case 1://创建哈夫曼树和哈夫曼编码表
				{
					system("cls");
					CreateHuffmanTree(tree);
					FILE* fp;
					if ((fp = fopen("hfmTree.txt", "w")) == NULL) {
						cout << "文件打开失败！" << endl;
						exit(0);
					}
					for (int i = 1; i < hufftreenum; i++) {
						fprintf(fp, "%d		%c		%.0f		%d		%d		%d\n", i, tree[i].data, tree[i].weight, tree[i].parent, tree[i].lchild, tree[i].rchild);
					}
					cout << "哈夫曼树成功写入hfmTree.txt文件" << endl;
					fclose(fp);
					PrintHuffmanTree(tree);
					CreateCodeHuffman();
					break;
				}
				case 2://打印哈夫曼编码表
				{
					system("cls");
					PrintHuffmanCode(code);
					break;
				}
				case 3://哈夫曼编码
				{
					system("cls");
					FILE* fp;
					if ((fp = fopen("TobeTran.txt", "r")) == NULL) {
						cout << "文件打开失败！" << endl;
						exit(0);
					}
					char* str = new char[MAXSIZE];
					for (int i = 0; i < MAXSIZE; i++)
						str[i] = '\0';
					int j = 0;
					while (!feof(fp)) {
						str[j++] = fgetc(fp);
					}
					str[j-1] = '\0';
					fclose(fp);
					printf("将要编码的字符串为：%s\n",str);
					WriteHuffmanCode(str, code, tree);
					cout << endl<<"编码成功" << endl;
					FILE* fp2;
					if ((fp2 = fopen("codefile.txt", "w")) == NULL)
					{
						printf("文件打开失败！\n");
						exit(0);
					}
					fprintf(fp2, "%s", hufcode);
					fclose(fp2);
					break;
				}
				case 4://哈夫曼译码
				{
					system("cls");
					FILE* fp;
					if ((fp = fopen("codefile.txt", "r")) == NULL) {
						cout << "文件打开失败！" << endl;
						exit(0);
					}
					char* buffer = new char[MAXSIZE];
					for (int i = 0; i < MAXSIZE; i++)
						buffer[i] = '\0';
					int j = 0;
					while (!feof(fp))
						buffer[j++] = fgetc(fp);
					buffer[j - 1] = '\0';
					fclose(fp);
					TransHuffmanCode(code, tree, buffer);
					cout << "codefile文件中代码译码为:" << transcode << endl;
					FILE* fp2;
					if ((fp2 = fopen("TextFile.txt", "w")) == NULL) {
						cout << "文件打开失败！" << endl;
						exit(0);
					}
					fprintf(fp2, "%s", transcode);
					fclose(fp2);
					cout << "译码成功写入TextFile文件" << endl;
					break;
				}
				case 5: //打印codefile代码文件
				{
					system("cls");
					FILE* fp;
					if ((fp = fopen("codefile.txt", "r")) == NULL) {
						cout << "文件打开失败！" << endl;
						exit(0);
					}
					char* buffer = new char[MAXSIZE];
					for (int i = 0; i < MAXSIZE; i++)
						buffer[i] = '\0';
					int j = 0;
					while (!feof(fp))
						buffer[j++] = fgetc(fp);
					buffer[j - 1] = '\0';
					cout << "哈夫曼编码为：" << endl;
					for (int k = 0; k < strlen(buffer); k++) {
						cout << buffer[k];
						if ((k + 1) % 50 == 0) cout << endl;
					}
					fclose(fp);
					FILE* fp2;
					if ((fp2 = fopen("TextFile.txt", "r")) == NULL) {
						cout << "文件打开失败！" << endl;
						exit(0);
					}
					char* buf = new char[MAXSIZE];
					for (int i = 0; i < MAXSIZE; i++)
						buf[i] = '\0';
					j = 0;
					while (!feof(fp2))
						buf[j++] = fgetc(fp);
					buf[j - 1] = '\0';
					fclose(fp2);
					break;
				}
			}
		}
	system("pause");
	}
}

int main() {
	Menu();
	return 0;
}
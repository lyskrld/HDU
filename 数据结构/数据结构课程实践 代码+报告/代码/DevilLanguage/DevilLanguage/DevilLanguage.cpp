
#include<iostream>
using namespace std;

typedef struct QueueNode {
	char data;
	QueueNode* next;
};//队列结构体

struct Queue {
	QueueNode* front;//队首指向链表第一个元素的前面
	QueueNode* back;//队尾指向链表最后一个元素
	int length;//队列长度
};//队列

typedef struct StackNode{
	char data;
	StackNode* next;
};//栈结构体

struct Stack {
	StackNode* top;//指向栈顶元素的顶部
	int length;//栈的长度
};//栈

void InitStack(Stack* S) {
	S->top = new StackNode;
	S->top->next = NULL;
	S->length = 0;
}//初始化栈

bool Push(Stack* S,char e) {
	StackNode* node = new StackNode;
	node->data = e;
	node->next = S->top->next;
	S->top->next = node;
	S->length++;
	return true;
}//入栈

char Pop(Stack* S) {
	StackNode* node = S->top->next;
	char e = node->data;
	S->top->next = node->next;
	delete node;
	S->length--;
	return e;
}//出栈

bool EmptyStack(Stack* stk) {
	if (stk->top->next == NULL) return 1;
	else return 0;
}//判栈空

char GetTop(Stack* stk) {
	return stk->top->next->data;
}//取栈顶元素

void DestroyStack(Stack* S) {
	while (S->top->next != NULL) {
		Pop(S);
	}
	return;
}//销毁栈

void PrintStack(Stack* S) {
	StackNode* T = S->top->next;
	while (T != NULL) {
		cout << T->data << ' ';
		T = T->next;
	}
	if (!S->length) cout << "No Element.";
	cout << endl;
}//输出栈

void InitQueue(Queue* Q) {
	Q->front = new QueueNode;
	Q->back=Q->front;
	Q->length = 0;
}//初始化队列

void Enqueue(Queue* Q,char e) {
	QueueNode* node= new QueueNode;
	node->data = e;
	node->next = NULL;
	Q->back->next = node;
	Q->back = node;
	Q->length++;
}//入列

char Dequeue(Queue* Q) {
	if (Q->front == Q->back) {
		return -1;
	}
	QueueNode* node = Q->front->next;
	char e = node->data;
	Q->front->next= node->next;
	delete node;
	Q->length--;
	return e;
}//出列

void DestroyQueue(Queue* Q) {
	while (Q->front->next != NULL) {
		Dequeue(Q);
	}
}//销毁队列

void printA() {
	cout << "sae";
}//翻译字符A

void PrintQueue(Queue* Q) {
	QueueNode* P = Q->front->next;
	while (P != NULL) {
		if (P->data == 'A') {//翻译‘A’
			printA();
		}
		else if (P->data == 'B') {//翻译‘B’
			cout << 't';
			printA();
			cout << 'd';
			printA();
		}
		else cout << P->data;//直接输出小写字母
		P = P->next;
	}
	cout << endl;
}//打印队列

void Read(Stack* s, Queue* q) {
	string str;
	cin >> str;//输入字符串
	int i = 0;
	while (i < str.size()) {//按规则翻译字符串
		if (str[i] == '(') {//有括号先处理括号内元素
			Push(s, str[i]);//入左括号
			char theta;
			int flag = 0;
			while (str[++i] != ')') {//遍历括号内元素
				if (flag == 0) {//θ未记录，需要记录θ
					theta = str[i];//记录θ
					Push(s, str[i]);//小写字母直接入栈
					flag = 1;
					continue;
				}
				else {//θ记录好了，按规则入栈
					Push(s, str[i]);
					Push(s, theta);
				}
			}
			while (GetTop(s) != '(') {//把栈内的元素移到队列内
				Enqueue(q, GetTop(s));
				Pop(s);
			}
			Pop(s);//弹出左括号
		}
		else Enqueue(q, str[i]);
		i++;
	}
}//读入魔王语言并翻译

int main() {
	Stack* stk=new Stack;
	Queue* queue = new Queue;
	InitQueue(queue);//初始化队列
	InitStack(stk);//初始化栈
	Read(stk,queue);//读取并翻译魔王语言
	PrintQueue(queue);//输出魔王语言
	return 0;
}
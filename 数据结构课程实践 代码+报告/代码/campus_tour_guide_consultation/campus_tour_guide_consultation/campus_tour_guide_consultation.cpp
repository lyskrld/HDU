#include<iostream>
#include<fstream>
#include<sstream>
#include<opencv.hpp>
#define INFINITY 99999
using namespace std;
using namespace cv;
#define MaxVertexNum 100
#define MAXSIZE 1000
typedef char VertexType;
typedef int EdgeType;

//边
typedef struct EdgeNode {
	int adjvex;
	EdgeType weight;
	struct EdgeNode* next;
}EdgeNode;

//点
typedef struct VertexNode {
	VertexType data;//景点代号
	string name;//景点名称
	string brief;//景点简介
	EdgeNode* firstedge;
}VertexNode, AdjList[MaxVertexNum];

//邻接表
typedef struct {
	AdjList adjList;
	int numVertexes, numEdges;
}AGraph;

AGraph graph;
bool visited[MaxVertexNum];
int* dist = new int[graph.numVertexes];//（迪杰斯特拉）记录点到各点的最短路径长度
int* path = new int[graph.numVertexes];//记录路径下标

//找点
int LocateVex(VertexType v) {
	for (int i = 0; i < graph.numVertexes; i++)
		if (graph.adjList[i].data == v)
			return i;
	cout << "输入错误！";
	exit(0);
}

//获取边的权重
int getWeight(AGraph G, int v, int w) {
	EdgeNode* edge = G.adjList[v].firstedge;
	while (edge != NULL) {
		if (edge->adjvex == w)
			return edge->weight;
		edge = edge->next;
	}
	return INFINITY;
}

//建图
void CreateGraph(AGraph&graph, VertexType v, VertexType w, int wei) {
	EdgeNode* tail;
	int i = 0, j = 0;
	int indexv = LocateVex(v);
	int indexw = LocateVex(w);
	EdgeNode* e1 = new EdgeNode;
	tail = graph.adjList[indexv].firstedge;
	graph.adjList[indexv].firstedge = e1;
	e1->next = tail;
	e1->adjvex = indexw;
	e1->weight = wei;

	EdgeNode* e2 = new EdgeNode;
	tail = graph.adjList[indexw].firstedge;
	graph.adjList[indexw].firstedge = e2;
	e2->next = tail;
	e2->adjvex = indexv;
	e2->weight = wei;
}

//第一条边
int FirstNeighbor(AGraph G, int v) {
	if(G.adjList[v].firstedge!=NULL)
	return G.adjList[v].firstedge->adjvex;
	return -1;
}

//其他边
int NextNeighbor(AGraph G, int v, int w) {
	if (v != -1) {
		EdgeNode* edge = G.adjList[v].firstedge;
		while (edge != NULL && edge->adjvex != w) edge = edge->next;
		if (edge != NULL && edge->next != NULL) return edge->next->adjvex;
	}
	return -1;
}

//递归打印迪杰斯特拉路径
void print_the_path(int path[],int begin, int i) {
	if (i == begin) return;
	print_the_path(path, begin,path[i]);
	cout << "->" << graph.adjList[i].name << '(' << graph.adjList[i].data << ')';
}

//查找所有路径
void DFS(int begin,int end,int&i,int &k,int&minindex,int&maxindex,int&minpath,int&maxpath) {
	visited[begin] = true;
	int sum;//统计路径长度
	path[k++] = begin;
	if (begin == end) {
		sum = 0;
		cout << "路线"<<i<<"："<<graph.adjList[path[0]].name<<'('<<graph.adjList[path[0]].data<<')';
		for (int j = 1; j < k; j++) {
			sum += getWeight(graph,path[j - 1], path[j]);
			cout <<"——>"<< graph.adjList[path[j]].name << '(' << graph.adjList[path[j]].data << ')';
		}
		cout <<endl<<"路径长度为："<<sum<< endl;
		if (sum < minpath) {
			minpath = sum;
			minindex = i;
		}
		if (sum > maxpath) {
			maxpath = sum;
			maxindex = i;
		}
		i++;
	}
	for (int w = FirstNeighbor(graph, begin); w != -1; w = NextNeighbor(graph, begin, w)) {
		if (!visited[w])
			DFS(w,end,i,k,minindex,maxindex,minpath,maxpath);
	}
	visited[begin] = false; //一条简单路径处理完，退回一个顶点继续遍历
	k--;
}

//迪杰斯特拉算法
void dijkstra(AGraph G, int dist[],int path[],int begin) {
	int i, j, u, min;
	int weight;
	for (i = 0; i < G.numVertexes; i++) {
		path[i] = -1;
		visited[i] = false;
		dist[i] = INFINITY;
	}

	EdgeNode* edge = G.adjList[begin].firstedge;
	while (edge != NULL) {
		dist[edge->adjvex] = edge->weight;
		path[edge->adjvex] = begin;
		edge = edge->next;
	}

	visited[begin] = true;
	dist[begin] = 0;

	//找最小路径的弧头
	for (i = 1; i < G.numVertexes; i++) {
		min = INFINITY;
		for (j = 0; j < G.numVertexes; j++) {
			if (visited[j] == false && dist[j] < min) {
				min = dist[j];
				u = j;
			}
		}
	    visited[u] = true;

		//更新下一次最短路径
		for (j = 0; j < G.numVertexes; j++) {
			weight = getWeight(G, u, j);
			if (visited[j] == false && dist[u] + weight < dist[j]) {
				dist[j] = dist[u] + weight;
				path[j] = u;
			}
		}
	}

}

//打印景点信息
void PrintSite() {
	cout << "杭州电子科技大学景点信息：" << endl;
	cout << "代号" << "	  " << "景点" << "                       " << "简介" << endl;
	for (int i = 0; i < graph.numVertexes; i++) {
		int num = 0;
		VertexNode v=graph.adjList[i];
		cout <<' '<< v.data << "	" << v.name << "	";
		while (num<(int)v.brief.size()) {
			cout << v.brief[num++];
			if (num % 30 == 0)cout <<endl << "			" ;
		}
		cout << endl<<endl;
	}
}

//打印邻接表
void PrintGraph() {
	for (int i = 0; i < graph.numVertexes; i++) {
		VertexNode v = graph.adjList[i];
		EdgeNode* first = v.firstedge;
		cout << i << ' ' << v.data;
		while (first != NULL) {
			cout <<' '<<graph.adjList[first->adjvex].data;
			first = first->next;
		}
		cout << endl;
	}
	cout << endl;
}

//打印所有边
void PrintPath() {
	FILE* fp;
	if ((fp = fopen("path.txt", "r")) == NULL) {
		cout << "文件打开失败！" << endl;
		exit(0);
	}
	VertexType v, w;
	int weight;
	int i = 0;
	while (fscanf(fp, "%c %c %d\n", &v, &w, &weight) != EOF) {
		int indexv=LocateVex(v);
		int indexw = LocateVex(w);
		cout << i+1 << '.';
		cout << graph.adjList[indexv].name << '(' << graph.adjList[indexv].data << ')'
	    	 << "------" << graph.adjList[indexw].name << '(' << graph.adjList[indexw].data << ')'
	       	 << "  路径长度：" << weight << endl;
		i++;
	}
	fclose(fp);
}

//打印指定景点信息
void ShowInfo(VertexType v) {
	int index=LocateVex(v);
	cout << "景点" << graph.adjList[index].data << graph.adjList[index].name << "的简介：" << endl;
	cout << graph.adjList[index].brief << endl;
}

void ShowMenu() {
	cout << " =============================================================================\n";
	cout << "||                ★★★★★★★杭州电子科技大学校园十景导览★★★★★★★                  ||\n";
	cout << "||============================================================================||\n";
	cout << "||============================================================================||\n";
	cout << "||                     【0】--- 退出                                          ||\n";
	cout << "||                     【1】--- 创建杭电十景图                                ||\n";
	cout << "||                     【2】--- 查询杭电十景信息                              ||\n";
	cout << "||                     【3】--- 查询两个景点之间的最短路径                    ||\n";
	cout << "||                     【4】--- 查询两个景点之间的所有路径                    ||\n";
	cout << "||                     【5】--- 打印杭电十景分布图                            ||\n";
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
				case 1://创建校园十景图
				{
					system("cls");
					char buf[MAXSIZE];
					int num = 0,line_num=0;
					fstream out;
					out.open("site.txt", ios::in);
					while (!out.eof()) {
						out.getline(buf, MAXSIZE, '\n');
						line_num++;
						if (line_num % 3 == 1) {
							graph.adjList[(line_num - 1) / 3].data = buf[0];
							graph.adjList[(line_num - 1) / 3].firstedge = NULL;
						}
						if (line_num % 3 == 2)
							graph.adjList[(line_num - 1) / 3].name = buf;
						if (line_num % 3 == 0)
							graph.adjList[(line_num - 1) / 3].brief = buf;
					}
					out.close();
					graph.numVertexes = line_num / 3;
					FILE* fp;
					if ((fp = fopen("path.txt", "r")) == NULL) {
						cout << "文件打开失败！" << endl;
						exit(0);
					}
					VertexType v, w;
					int weight;
					while (fscanf(fp, "%c %c %d\n", &v, &w, &weight) != EOF) {
						CreateGraph(graph, v, w, weight);
						num++;
					}
					fclose(fp);
					graph.numEdges = num;
					cout << "创建成功" << endl;
					cout << "校园十景邻接图：" << endl;
					PrintGraph();
					cout << "校园十景信息：" << endl;
					PrintSite();
					cout << "校园十景路径：" << endl;
					PrintPath();
					break;
				}
				case 2://查询校园十景信息
				{
					system("cls");
					for (int i = 0; i < graph.numVertexes; i++) {
						cout << graph.adjList[i].data << '.' << graph.adjList[i].name << endl;
					}
					cout << "请输入需要查询的景点代号：";
					VertexType ch;
					cin >> ch;
					system("cls");
					ShowInfo(ch);
					break;
				}
				case 3://查询两个景点之间的最短路径
				{
					system("cls");
					VertexType v, w;
					for (int i = 0; i < graph.numVertexes; i++) {
						cout << graph.adjList[i].data << '.' << graph.adjList[i].name << endl;
					}
					cout << "请输入需要查询的起点景点代号：";
					cin >>v;
					cout << "请输入需要查询的终点景点代号：";
					cin >>w;
					int begin = LocateVex(v);
					int end = LocateVex(w);
					dijkstra(graph, dist, path, begin);
					cout << "从" << graph.adjList[begin].name << '(' << graph.adjList[begin].data << ')'
						 << "到" << graph.adjList[end].name << '(' << graph.adjList[end].data << ')' << "的最短路线为：";
					cout << graph.adjList[begin].name << '(' << graph.adjList[begin].data << ')';
					print_the_path(path, begin,end);
					cout << " 路径长度为" << dist[end]<<endl;
					break;
				}
				case 4://查询景点之间的所有路径
				{
					system("cls");
					VertexType v, w;
					for (int i = 0; i < graph.numVertexes; i++) {
						cout << graph.adjList[i].data << '.' << graph.adjList[i].name << endl;
					}
					cout << "请输入需要查询的起点景点代号：";
					cin >> v;
					cout << "请输入需要查询的终点景点代号：";
					cin >> w;
					int begin = LocateVex(v);
					int end = LocateVex(w);
					for (int i = 0; i < graph.numVertexes; i++) {
						visited[i] = false;
						path[i] = -1;
					}
					int k = 0,i=1;
					int minindex, maxindex;
					int minpath=MAXSIZE, maxpath=0;
				    cout << "从" << graph.adjList[begin].name << '(' << graph.adjList[begin].data << ')'
						<< "到" << graph.adjList[end].name << '(' << graph.adjList[end].data << ')'
						<< "的所有路线为："<<endl;
					DFS(begin, end,i,k,minindex,maxindex,minpath,maxpath);
					cout << endl;
					cout << "最长路线为第" << maxindex << "条路线，路径长度为" << maxpath<<endl;
					cout << "最短路线为第" << minindex << "条路线，路径长度为" << minpath<<endl;
					break;
				}
				case 5:
				{
					string str = "杭电十景.jpg";
					Mat image = imread(str);
					namedWindow("HDU", WINDOW_NORMAL);
					imshow("HDU", image);
					waitKey(0);
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
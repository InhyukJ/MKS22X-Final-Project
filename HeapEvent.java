import java.util.NoSuchElementException;
import java.lang.Math;


public class HeapEvent{
    private Event[] heap;
    private int constant;
    private int size;


    public HeapEvent(){
	heap = new Event[10];
	constant = 1;
	size = 0;
    }

    public HeapEvent(boolean max){
	heap = new Event[10];
	size = 0;
	if(max){
	    constant = 1;
	}else{
	    constant = -1;
	}
    }

    private void resize(){
	Event[] copy = new Event[heap.length * 2];
	for(int i = 1; i < heap.length; i++){
	    copy[i] = heap[i];
	}
	heap = copy;
    }

    private int childLI(int nodeI){ 
	return 2 * nodeI;
    }

    private int childRI(int nodeI){
	return 2 * nodeI + 1;
    }

    private int parent(int nodeI){
	return nodeI / 2;
    }

    private void swap(int node1, int node2){
	Event holder = heap[node1];
	heap[node1] = heap[node2];
	heap[node2] = holder;
    }

    private void pushUp(int nodeI){ 
	if(nodeI != 1 && heap[nodeI].compareTo(heap[parent(nodeI)]) * constant > 0){
	    swap(nodeI, parent(nodeI));
	    pushUp(parent(nodeI));
	}
    }

    private void pushDown(int nodeI){
	if(childRI(nodeI) <= size){
	    if(heap[nodeI].compareTo(heap[childRI(nodeI)]) * constant < 0 && heap[nodeI].compareTo(heap[childLI(nodeI)]) * constant < 0){
		if(heap[childRI(nodeI)].compareTo(heap[childLI(nodeI)]) * constant >= 0){
		    swap(nodeI, childRI(nodeI));
		    pushDown(childRI(nodeI));
		}else{
		   swap(nodeI, childLI(nodeI));
		   pushDown(childLI(nodeI)); 
		}
	    }else if(heap[nodeI].compareTo(heap[childRI(nodeI)]) * constant < 0){
		swap(nodeI, childRI(nodeI));
		pushDown(childRI(nodeI));
	    }else if(heap[nodeI].compareTo(heap[childLI(nodeI)]) * constant < 0){
		swap(nodeI, childLI(nodeI));
		pushDown(childLI(nodeI));
	    }
	}else if(childLI(nodeI) <= size && heap[nodeI].compareTo(heap[childLI(nodeI)]) * constant < 0){
	    swap(nodeI, childLI(nodeI));
	    pushDown(childLI(nodeI));
	}
    }

    public int getSize(){
	return size;
    }

    public void add(Event s){
	size++;
	if(size >= heap.length){
	    resize();
	}
	heap[size] = s;
	pushUp(size);
    }

    public Event remove(){
	if(size > 0){
	    Event removed = heap[1];
	    heap[1] = heap[size];
	    heap[size] = null;
	    size--;
	    pushDown(1);
	    return removed;
	}else{
	    throw new NoSuchElementException("The heap is empty.");
	}
    }

    public Event peek(){
	if(size > 0){
	    return heap[1];
	}else{
	    throw new NoSuchElementException("The heap is empty.");
	}
    }

    public String toString(){
	String printVer = "[";
	if(heap.length > 0){
	    printVer += " ";
	    for(Event str : heap){
		printVer += ", " + str;
	    }
	}
	printVer += "]";
	return printVer;
    }

    public String toStringTree(){
	String printVer = "";
	int i = 1;
	for(int n = 0; i <= size; n++){
	    for(int j = 0; j < Math.pow(2, n) && i <= size; j++, i++){
	        printVer += heap[i] + " - ";
	    }
	    printVer += "\n";
	}
	return printVer;
    }


    public static void main(String[] args){
	
    }
}

public class PriorityQueueEvent{
    private HeapEvent heap;

    public PriorityQueueEvent(){ 
	heap = new HeapEvent(false); //minHeap b/c want shorter distances
    }

    public void add(Event event){
	heap.add(event);
    }

    public Event peek(){
	return heap.peek();
    }

    public Event next(){
	return heap.remove();
    }

    public boolean hasNext(){
	return heap.getSize() != 0;
    }

    public void update(){ //seems inefficient 
	HeapEvent newheap = new HeapEvent(false);
	while(hasNext()){
	    newheap.add(next());
	}
	heap = newheap;
    }

    public String toString(){
	return heap.toStringTree();
    }

    
    public static void main(String[] args){

    }
}

public class PriorityQueueEvent{
    private HeapEvent heap;

    public PriorityQueueEvent(){ 
	//probably needs arguments, like ArrayList of Objs - actually, can deal with adding in the EventListener
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

    public String toString(){
	return heap.toStringTree();
    }

    
    public static void main(String[] args){

    }
}

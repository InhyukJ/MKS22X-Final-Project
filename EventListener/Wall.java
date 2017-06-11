public class Wall implements Obj{
    float x, y, width, height;
    boolean topLeft, horizontal;

    public Wall(boolean topLeft, boolean horizontal){
	this.topLeft = topLeft;
	this.horizontal = horizontal;
	if(topLeft && horizontal){
	    x = 30.0f;
	    y = 30.0f;
	    width = 650.0f;
	    height = 5.0f;
	}else if(topLeft && !horizontal){
	    x = 30.0f;
	    y = 30.0f;
	    width = 5.0f;
	    height = 350.0f;
	}else if(horizontal){
	    x = 30.0f;
	    y = 375.0f;
	    width = 650.0f;
	    height = 5.0f;
	}else{
	    x = 675.0f;
	    y = 30.0f;
	    width = 5.0f;
	    height = 350.0f;
	}
    }

    public float getX(){
	return x;
    }

    public float getY(){
	return y;
    }

    public float getWidth(){
	return width;
    }

    public float getHeight(){
	return height;
    }

    public boolean isTopLeft(){
	return topLeft;
    }

    public boolean isHorizontal(){
	return horizontal;
    }

    public boolean isWall(){
	return true;
    }

    
    public static void main(String[] args){

    }
}

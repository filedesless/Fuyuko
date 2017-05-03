package felix;

class FelixCircularList<T> {
    public var head:FelixCircularListNode<T> = null;
    public var tail:FelixCircularListNode<T> = null;

    public function new():Void { }

    public var length:Int = 0;

    public function add(item:T):Void {
        if (length == 0) {
            head = new FelixCircularListNode(item);
            head.next = head;
            head.prev = head;
            tail = head;
        } else {
            head = new FelixCircularListNode(item, tail, head);
            tail.next = head;
            head.next.prev = head;
        }

        ++length;
    }

}
package felix;

class FelixCircularListNode<T> {
    public var item:T;
    public var next:FelixCircularListNode<T>;
    public var prev:FelixCircularListNode<T>;

    public function new(item:T, ?prev:FelixCircularListNode<T>, ?next:FelixCircularListNode<T>) {
        this.item = item;
        this.next = next;
        this.prev = prev;
    }
}

class FelixCircularList<T> {
    public var head:FelixCircularListNode<T> = null;
    public var tail:FelixCircularListNode<T> = null;

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
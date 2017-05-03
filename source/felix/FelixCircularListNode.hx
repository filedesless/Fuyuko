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
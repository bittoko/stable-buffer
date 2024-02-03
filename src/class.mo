import { toNat = nat64ToNat; fromNat = nat64FromNat } "mo:base/Nat64";
import { trap } "mo:base/Debug";
import Region "mo:base/Region";
import T "types";
import C "const";

module {

  public class StableBuffer(state: T.State) = {

    public func size() : Nat = nat64ToNat( state.next );

    public func get(i: Nat): Blob {
      let index : Nat64 = nat64FromNat( i );
      if ( index >= state.next ) trap("mo:stable-array/class: line 15");
      Region.loadBlob(state.elements, get_offset(index), nat64ToNat(state.element_size))
    };

    public func getOpt(i: Nat): ?Blob {
      let index : Nat64 = nat64FromNat( i );
      if ( index >= state.next ) return null;
      ?Region.loadBlob(state.elements, get_offset(index), nat64ToNat(state.element_size))
    };

    public func set(i: Nat, b: Blob): T.Return<Nat> {
      let index : Nat64 = nat64FromNat( i );
      let size : Nat = nat64ToNat( state.element_size);
      if ( index >= state.next ) return #err(#out_of_bounds);
      if ( b.size() != size ) return #err(#size_error("expected: " # debug_show(state.element_size) # "; received: " # debug_show(b.size())));
      Region.storeBlob(state.elements, get_offset(index), b);
      #ok(i)
    };

    public func append(b: Blob): T.Return<Nat> {
      let index : Nat = nat64ToNat( state.next );
      if ( state.next >= state.capacity ){
        if( Region.grow(state.elements, 1) == C.MEMORY_EXHAUSTED ) return #err(#insufficient_memory);
        state.capacity += state.elements_per_page;
      };
      state.next += 1;
      set(index, b)
    };

    func get_offset(i: Nat64): Nat64 {
      let div : Nat64 = i / state.elements_per_page;
      let mod : Nat64 = i % state.elements_per_page;
      if ( div + mod == 0 ) 0x00000000
      else if ( mod == 0) (C.PAGE_SIZE * div) - state.element_size - 1
      else (C.PAGE_SIZE * div) + (state.element_size * (mod-1)) - 1
    };

  };
  

};
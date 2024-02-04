import SB "../../src";
import { range; toArray } "mo:base/Iter";
import Array "mo:base/Array";
import Blob "mo:base/Blob";

actor {

  stable let state = SB.State.init({size=122; capacity=1000});
  
  let buffer = SB.StableBuffer( state );

  public query func capacity(): async Nat { buffer.capacity() };

  public query func vals(): async [Blob] { toArray<Blob>( buffer.vals() ) };

  public query func get(i: Nat): async Blob { buffer.get(i) };

  public func add(): async SB.Return<Nat> {
    var byte : Nat8 = 0x00;
    let capacity : Nat = buffer.capacity();
    for ( inc in range(0, capacity) ) {
      if ( byte < 255 ) byte += 1;
      let blob : Blob = Blob.fromArray( Array.tabulate<Nat8>(122, func(_)=byte) );
      switch( buffer.add(blob) ){
        case( #err msg ) return #err(msg);
        case( #ok _ ) ()
      };
    };
    #ok(0)
  };

};

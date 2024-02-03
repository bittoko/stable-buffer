import SB "../../src";

actor {

  let state = SB.State.init({size=3; capacity=1000});
  
  let buffer = SB.StableBuffer( state );

  public query func getCapacity(): async Nat64 { state.capacity };

  public func append(b: Blob): async SB.Return<Nat> { buffer.append(b) };

  public query func get(i: Nat): async Blob { buffer.get(i) };

};

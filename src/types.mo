import Region "mo:base/Region";

module {

  public type Region = Region.Region;

  public type Return<T> = { #ok: T; #err: Error };

  public type Error = { #insufficient_memory; #size_error: Text; #out_of_bounds };

  public type StableBuffer = {
    size : () -> Nat;
    get : (Nat) -> Blob;
    getOpt : (Nat) -> ?Blob;
    set : (Nat, Blob) -> Return<()>;
    append : (Blob) -> Return<Nat>;
  };

  public type State = {
    var next : Nat64;
    var capacity: Nat64;
    elements_per_page : Nat64;
    element_size : Nat64;
    elements : Region;
  };

}
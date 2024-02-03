import { test; suite } "mo:test";
import SB "../src";

suite("Stable Buffer Tests", func(){

  var state : ?SB.State = null;

  test("init", func(){
    state := ?SB.State.init({size=122; capacity=1000});
  });

  test("append", func(){});

  test("get | success", func(){});

  test("set | sucess", func(){});

  test("getOpt | null", func(){});

  test("getOpt | some", func(){});

  test("", func(){});

  test("", func(){});

})
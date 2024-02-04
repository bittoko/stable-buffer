export const idlFactory = ({ IDL }) => {
  const Error = IDL.Variant({
    'out_of_bounds' : IDL.Null,
    'insufficient_memory' : IDL.Null,
    'size_error' : IDL.Text,
  });
  const Return = IDL.Variant({ 'ok' : IDL.Nat, 'err' : Error });
  return IDL.Service({
    'append' : IDL.Func([], [Return], []),
    'capacity' : IDL.Func([], [IDL.Nat], ['query']),
    'get' : IDL.Func([IDL.Nat], [IDL.Vec(IDL.Nat8)], ['query']),
    'vals' : IDL.Func([], [IDL.Vec(IDL.Vec(IDL.Nat8))], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };

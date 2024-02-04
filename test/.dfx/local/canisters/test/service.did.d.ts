import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export type Error = { 'out_of_bounds' : null } |
  { 'insufficient_memory' : null } |
  { 'size_error' : string };
export type Return = { 'ok' : bigint } |
  { 'err' : Error };
export interface _SERVICE {
  'append' : ActorMethod<[], Return>,
  'capacity' : ActorMethod<[], bigint>,
  'get' : ActorMethod<[bigint], Uint8Array | number[]>,
  'vals' : ActorMethod<[], Array<Uint8Array | number[]>>,
}

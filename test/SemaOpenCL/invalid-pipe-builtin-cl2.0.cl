// RUN: %clang_cc1 %s -verify -pedantic -fsyntax-only -cl-std=CL2.0

void test1(read_only pipe int p, global int* ptr){
  int tmp;
  reserve_id_t rid;

  // read/write_pipe
  read_pipe(tmp, p);    // expected-error {{first argument to read_pipe must be a pipe type}}
  read_pipe(p);   // expected-error {{invalid number of arguments to function: read_pipe}}
  read_pipe(p, tmp, tmp, ptr);   // expected-error {{invalid argument type to function read_pipe (expecting 'reserve_id_t')}}
  read_pipe(p, rid, rid, ptr);   // expected-error {{invalid argument type to function read_pipe (expecting 'unsigned int')}}
  read_pipe(p, tmp);   // expected-error {{invalid argument type to function read_pipe (expecting 'int *')}}
  write_pipe(p, ptr);    // expected-error {{invalid pipe access modifier (expecting write_only)}}
  write_pipe(p, rid, tmp, ptr);    // expected-error {{invalid pipe access modifier (expecting write_only)}}

  // reserve_read/write_pipe
  reserve_read_pipe(p, ptr);    // expected-error{{invalid argument type to function reserve_read_pipe (expecting 'unsigned int')}}
  work_group_reserve_read_pipe(tmp, tmp);    // expected-error{{first argument to work_group_reserve_read_pipe must be a pipe type}}
  sub_group_reserve_write_pipe(p, tmp);    // expected-error{{invalid pipe access modifier (expecting write_only)}}

  // commit_read/write_pipe
  commit_read_pipe(tmp, rid);    // expected-error{{first argument to commit_read_pipe must be a pipe type}}
  work_group_commit_read_pipe(p, tmp);    // expected-error{{invalid argument type to function work_group_commit_read_pipe (expecting 'reserve_id_t')}}
  sub_group_commit_write_pipe(p, tmp);    // expected-error{{invalid pipe access modifier (expecting write_only)}}
}

void test2(write_only pipe int p, global int* ptr){
  int tmp;
  reserve_id_t rid;

  // read/write_pipe
  write_pipe(tmp, p);    // expected-error {{first argument to write_pipe must be a pipe type}}
  write_pipe(p);   // expected-error {{invalid number of arguments to function: write_pipe}}
  write_pipe(p, tmp, tmp, ptr);   // expected-error {{invalid argument type to function write_pipe (expecting 'reserve_id_t')}}
  write_pipe(p, rid, rid, ptr);   // expected-error {{invalid argument type to function write_pipe (expecting 'unsigned int')}}
  write_pipe(p, tmp);   // expected-error {{invalid argument type to function write_pipe (expecting 'int *')}}
  read_pipe(p, ptr);    // expected-error {{invalid pipe access modifier (expecting read_only)}}
  read_pipe(p, rid, tmp, ptr);    // expected-error {{invalid pipe access modifier (expecting read_only)}}

  // reserve_read/write_pipe
  reserve_write_pipe(p, ptr);    // expected-error{{invalid argument type to function reserve_write_pipe (expecting 'unsigned int')}}
  work_group_reserve_write_pipe(tmp, tmp);    // expected-error{{first argument to work_group_reserve_write_pipe must be a pipe type}}
  sub_group_reserve_read_pipe(p, tmp);    // expected-error{{invalid pipe access modifier (expecting read_only)}}

  // commit_read/write_pipe
  commit_write_pipe(tmp, rid);    // expected-error{{first argument to commit_write_pipe must be a pipe type}}
  work_group_commit_write_pipe(p, tmp);    // expected-error{{invalid argument type to function work_group_commit_write_pipe (expecting 'reserve_id_t')}}
  sub_group_commit_read_pipe(p, tmp);    // expected-error{{invalid pipe access modifier (expecting read_only)}}
}

void test3(){
  int tmp;
  get_pipe_num_packets(tmp);    // expected-error {{first argument to get_pipe_num_packets must be a pipe type}}
  get_pipe_max_packets(tmp);    // expected-error {{first argument to get_pipe_max_packets must be a pipe type}}
}

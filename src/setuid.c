#include "erl_nif.h"
#include "unistd.h"

static ERL_NIF_TERM get_uid(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  return enif_make_int(env, getuid());
}

static ERL_NIF_TERM set_uid(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  int uid;
  enif_get_int(env, argv[0], &uid);

  if (!setuid(uid))
    return enif_make_int(env, 1);
  else
    return enif_make_int(env, -1);
}

static ERL_NIF_TERM get_gid(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  return enif_make_int(env, getgid());
}

static ERL_NIF_TERM set_gid(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  int gid;
  enif_get_int(env, argv[0], &gid);

  if (!setgid(gid))
    return enif_make_int(env, 1);
  else
    return enif_make_int(env, -1);
}

static ErlNifFunc nif_funcs[] = {
  {"getuid", 0, get_uid},
  {"setuid", 1, set_uid},
  {"getgid", 0, get_gid},
  {"setgid", 1, set_gid}
};

ERL_NIF_INIT(Elixir.Setuid, nif_funcs, NULL, NULL, NULL, NULL)

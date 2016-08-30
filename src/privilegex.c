#include "erl_nif.h"
#include <unistd.h>
#include <strings.h>
#include <pwd.h>
#include <grp.h>

char * alloc_and_copy_to_cstring(ErlNifBinary *string) {
  char *str = (char *) enif_alloc(string->size + 1);
  strncpy(str, (char *)string->data, string->size);

  str[string->size] = 0;

  return str;
}

static ERL_NIF_TERM get_uid(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  return enif_make_tuple2(env, enif_make_atom(env, "ok"), enif_make_int(env, getuid()));
}

static ERL_NIF_TERM set_uid(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  int uid;
  enif_get_int(env, argv[0], &uid);

  if (!setuid(uid))
    return enif_make_atom(env, "ok");
  else
    return enif_make_atom(env, "error");
}

static ERL_NIF_TERM get_gid(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  return enif_make_tuple2(env, enif_make_atom(env, "ok"), enif_make_int(env, getgid()));
}

static ERL_NIF_TERM set_gid(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  int gid;
  enif_get_int(env, argv[0], &gid);

  if (!setgid(gid))
    return enif_make_atom(env, "ok");
  else
    return enif_make_atom(env, "error");
}

static ERL_NIF_TERM get_pwnam(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  struct passwd *pwd;
  ErlNifBinary string;

  if (!enif_inspect_binary(env, argv[0], &string))
    return enif_make_badarg(env);

  char *name = alloc_and_copy_to_cstring(&string);

  pwd = getpwnam(name);

  if (pwd == 0)
    return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_string(env, "Not found", ERL_NIF_LATIN1));

  ERL_NIF_TERM pwd_map = enif_make_new_map(env);

  enif_make_map_put(env, pwd_map, enif_make_atom(env, "name"), enif_make_string(env, pwd->pw_name, ERL_NIF_LATIN1), &pwd_map);
  enif_make_map_put(env, pwd_map, enif_make_atom(env, "passwd"), enif_make_string(env, pwd->pw_passwd, ERL_NIF_LATIN1), &pwd_map);
  enif_make_map_put(env, pwd_map, enif_make_atom(env, "uid"), enif_make_int(env, pwd->pw_uid), &pwd_map);
  enif_make_map_put(env, pwd_map, enif_make_atom(env, "gid"), enif_make_int(env, pwd->pw_gid), &pwd_map);
  enif_make_map_put(env, pwd_map, enif_make_atom(env, "gecos"), enif_make_string(env, pwd->pw_gecos, ERL_NIF_LATIN1), &pwd_map);

  return enif_make_tuple2(env, enif_make_atom(env, "ok"), pwd_map);
}

static ERL_NIF_TERM get_grnam(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  struct group *grp;
  ErlNifBinary string;

  if (!enif_inspect_binary(env, argv[0], &string))
    return enif_make_badarg(env);

  char *name = alloc_and_copy_to_cstring(&string);

  grp = getgrnam(name);

  if (grp == 0)
    return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_string(env, "Not found", ERL_NIF_LATIN1));

  ERL_NIF_TERM grp_map = enif_make_new_map(env);

  enif_make_map_put(env, grp_map, enif_make_atom(env, "gid"), enif_make_int(env, grp->gr_gid), &grp_map);
  enif_make_map_put(env, grp_map, enif_make_atom(env, "name"), enif_make_string(env, grp->gr_name, ERL_NIF_LATIN1), &grp_map);
  enif_make_map_put(env, grp_map, enif_make_atom(env, "passwd"), enif_make_string(env, grp->gr_passwd, ERL_NIF_LATIN1), &grp_map);

  return enif_make_tuple2(env, enif_make_atom(env, "ok"), grp_map);
}

static ErlNifFunc nif_funcs[] = {
  {"getuid", 0, get_uid},
  {"setuid", 1, set_uid},
  {"getgid", 0, get_gid},
  {"setgid", 1, set_gid},
  {"getpwnam", 1, get_pwnam},
  {"getgrnam", 1, get_grnam}
};

ERL_NIF_INIT(Elixir.Privilegex, nif_funcs, NULL, NULL, NULL, NULL)

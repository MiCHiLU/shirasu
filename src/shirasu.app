{application, shirasu,
 [{description, "shirasu"},
  {vsn, "0.01"},
  {modules, [
    shirasu,
    shirasu_app,
    shirasu_sup
  ]},
  {registered, []},
  {mod, {shirasu_app, []}},
  {env, []},
  {setting, "priv/setting.yaml"},
  {applications, [kernel, stdlib]}]}.

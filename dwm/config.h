/* See LICENSE file for copyright and license details. */

/* Constants */
#define TERMINAL "kitty"
#define TERMCLASS "Kitty"
#define BROWSER "firefox"

#define BG_COLOR "#111315"
#define FG_COLOR "#f8f9fa"
// ["#f8f9fa","#e9ecef","#dee2e6","#ced4da","#adb5bd","#6c757d","#495057","#343a40","#212529"]
// ["#111315","#a7a9ab","#f8f9fa"] 	#073605 	(7,54,5)
	// #0e4e0b 	(14,78,11)
	// #145b11 	(20,91,17)
	// #146c11 	(20,108,17)
	// #199515 	(25,149,21)
/* appearance */
static const int horizpadbar  = 4;        /* horizontal padding for statusbar */
static const int vertpadbar   = 2;        /* vertical padding for statusbar */
static unsigned int borderpx  = 1;        /* border pixel of windows */
static unsigned int snap      = 32;       /* snap pixel */
static unsigned int gappih    = 10;       /* horiz inner gap between windows */
static unsigned int gappiv    = 10;       /* vert inner gap between windows */
static unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static unsigned int gappov    = 10;       /* vert outer gap between windows and screen edge */
static int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static int showbar            = 1;        /* 0 means no bar */
static int topbar             = 1;        /* 0 means bottom bar */
static char *fonts[]          = { "JetBrainsMono Nerd Font:size=14", "NotoColorEmoji:pixelsize=10:antialias=true:autohint=true"  };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:size=16";
static char normbgcolor[]           = BG_COLOR;
static char normbordercolor[]       = "#212529";
static char normfgcolor[]           = "#a7a9ab";
static char selfgcolor[]            = FG_COLOR;
static char selbordercolor[]        = "#a7a9ab";
static char selbgcolor[]            = BG_COLOR;
static char *colors[][3] = {
  /*               fg           bg           border   */
  [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
  [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
	[SchemeStatus]  = { selfgcolor, normbgcolor,  normbgcolor }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { selfgcolor, selbgcolor,  normbgcolor }, // Tagbar left selected {text,background,not used but cannot be empty}
	[SchemeTagsNorm]  = { normfgcolor, normbgcolor,  normbgcolor }, // Tagbar left unselected {text,background,not used but cannot be empty}
	[SchemeInfoSel]  = { selfgcolor, selbgcolor,  normbgcolor }, // infobar middle  selected {text,background,not used but cannot be empty}
	[SchemeInfoNorm]  = { normfgcolor, normbgcolor,  normbgcolor }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

typedef struct {
  const char *name;
  const void *cmd;
} Sp;
const char *spcmd1[] = {TERMINAL, "-n", "spterm", "-g", "120x34", NULL };
const char *spcmd2[] = {TERMINAL, "-n", "spcalc", "-f", "monospace:size=16", "-g", "50x20", "-e", "bc", "-lq", NULL };
static Sp scratchpads[] = {
  /* name          cmd  */
  {"spterm",      spcmd1},
  {"spcalc",      spcmd2},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
  /* xprop(1):
   *	WM_CLASS(STRING) = instance, class
   *	WM_NAME(STRING) = title
   */
  /* class                instance    title       tags mask     isfloating   monitor */
  { "Gimp",               NULL,       NULL,       0,            1,           -1 },
  // { "Google-chrome",      NULL,       NULL,       1 << 1,       0,           -1 },
  // { "firefox",            NULL,       NULL,       1 << 2,       0,           -1 },
};

/* layout(s) */
static float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"
static const Layout layouts[] = {
  /* symbol     arrange function */
  { "[]=",	tile },	                /* Default: Master on left, slaves on right */
  { "TTT",	bstack },               /* Master on top, slaves on bottom */

  { "[@]",	spiral },               /* Fibonacci spiral */
  { "[\\]",	dwindle },              /* Decreasing in size right and leftward */

  { "[D]",	deck },	                /* Master on left, slaves in monocle-like mode on right */
  { "[M]",	monocle },              /* All windows on top of eachother */

  { "|M|",	centeredmaster },               /* Master in middle, slaves on sides */
  { ">M>",	centeredfloatingmaster },       /* Same but master floats */

  { "><>",	NULL },	                /* no layout function means floating behavior */
  { NULL,		NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
{ MOD,	XK_j,	ACTION##stack,	{.i = INC(+1) } }, \
{ MOD,	XK_k,	ACTION##stack,	{.i = INC(-1) } }, \
{ MOD,  XK_v,   ACTION##stack,  {.i = 0 } }, \
/* { MOD, XK_grave, ACTION##stack, {.i = PREVSEL } }, \ */
/* { MOD, XK_a,     ACTION##stack, {.i = 1 } }, \ */
/* { MOD, XK_z,     ACTION##stack, {.i = 2 } }, \ */
/* { MOD, XK_x,     ACTION##stack, {.i = -1 } }, */

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { TERMINAL, NULL };
static const char *browser[]  = { BROWSER, "-P", NULL };
static const char *rofi[] = { "rofi", "-show", "drun", "-theme", "~/.config/rofi/config.rasi", NULL };
static const char *screenshotcmd[] = { "flameshot", "gui", NULL };
static const char *upvol[]   = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+", NULL };
static const char *downvol[] = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-", NULL };
static const char *mutevol[] = { "wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle", NULL };
static const char *suspend[] = { "systemctl", "suspend", NULL };

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
  { "color0",		STRING,	&normbordercolor },
  { "color8",		STRING,	&selbordercolor },
  { "color0",		STRING,	&normbgcolor },
  { "color4",		STRING,	&normfgcolor },
  { "color0",		STRING,	&selfgcolor },
  { "color4",		STRING,	&selbgcolor },
  { "borderpx",		INTEGER, &borderpx },
  { "snap",		INTEGER, &snap },
  { "showbar",		INTEGER, &showbar },
  { "topbar",		INTEGER, &topbar },
  { "nmaster",		INTEGER, &nmaster },
  { "resizehints",	INTEGER, &resizehints },
  { "mfact",		FLOAT,	&mfact },
  { "gappih",		INTEGER, &gappih },
  { "gappiv",		INTEGER, &gappiv },
  { "gappoh",		INTEGER, &gappoh },
  { "gappov",		INTEGER, &gappov },
  { "swallowfloating",	INTEGER, &swallowfloating },
  { "smartgaps",		INTEGER, &smartgaps },
};

#include <X11/XF86keysym.h>
#include "shiftview.c"

static const Key keys[] = {
  /* modifier                     key        function        argument */
  { 0,                            XF86XK_AudioMute,         spawn, {.v = mutevol } },
  { 0,                            XF86XK_AudioLowerVolume,  spawn, {.v = downvol } },
  { 0,                            XF86XK_AudioRaiseVolume,  spawn, {.v = upvol   } },
  { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
  { MODKEY,                       XK_m,      spawn,          {.v = suspend } },
  { MODKEY,                       XK_r,      spawn,          {.v = rofi } },
  { MODKEY,                       XK_q,      spawn,          {.v = termcmd } },
  { MODKEY,                       XK_b,      spawn,          {.v = browser} },
  { 0,                            XK_Print,  spawn,          {.v = screenshotcmd} },
  { MODKEY|ShiftMask,             XK_b,      togglebar,      {0} },
  // { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
  // { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
  { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
  { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
  { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
  { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
  { MODKEY,                       XK_j,      focussame,      {.i = +1 } },
  { MODKEY,                       XK_k,      focussame,      {.i = -1 } },
  { MODKEY,                       XK_Return, zoom,           {0} },
  { MODKEY,                       XK_Tab,    view,           {0} },
  { MODKEY,                       XK_c,      killclient,     {0} },
  { MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[0]} },
  { MODKEY|ShiftMask,             XK_f,      setlayout,      {.v = &layouts[1]} },
  // { MODKEY|ShiftMask,             XK_m,      setlayout,      {.v = &layouts[2]} },
  { MODKEY,                       XK_space,  setlayout,      {0} },
  { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_f,      togglefullscr,  {0} },
  { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
  { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
  { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
  { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
  { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
  { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
  { MODKEY|ShiftMask,             XK_m,      quit,           {0} },
  TAGKEYS(                        XK_1,                      0)
  TAGKEYS(                        XK_2,                      1)
  TAGKEYS(                        XK_3,                      2)
  TAGKEYS(                        XK_4,                      3)
  TAGKEYS(                        XK_5,                      4)
  TAGKEYS(                        XK_6,                      5)
  TAGKEYS(                        XK_7,                      6)
  TAGKEYS(                        XK_8,                      7)
  TAGKEYS(                        XK_9,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
  /* click                event mask           button          function        argument */
#ifndef __OpenBSD__
  { ClkWinTitle,          0,                   Button2,        zoom,           {0} },
  { ClkStatusText,        0,                   Button1,        sigdwmblocks,   {.i = 1} },
  { ClkStatusText,        0,                   Button2,        sigdwmblocks,   {.i = 2} },
  { ClkStatusText,        0,                   Button3,        sigdwmblocks,   {.i = 3} },
  { ClkStatusText,        0,                   Button4,        sigdwmblocks,   {.i = 4} },
  { ClkStatusText,        0,                   Button5,        sigdwmblocks,   {.i = 5} },
  { ClkStatusText,        ShiftMask,           Button1,        sigdwmblocks,   {.i = 6} },
#endif
  { ClkStatusText,        0,                   Button4,        spawn,          {.v = upvol  } },
  { ClkStatusText,        0,                   Button5,        spawn,          {.v = downvol} },
  { ClkStatusText,        ShiftMask,           Button3,        spawn,          SHCMD(TERMINAL " -e nvim ~/.local/src/dwmblocks/config.h") },
  { ClkClientWin,         MODKEY,              Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,              Button2,        defaultgaps,    {0} },
  { ClkClientWin,         MODKEY,              Button3,        resizemouse,    {0} },
  { ClkClientWin,		MODKEY,		     Button4,	     incrgaps,       {.i = +1} },
  { ClkClientWin,		MODKEY,		     Button5,	     incrgaps,       {.i = -1} },
  { ClkTagBar,            0,                   Button1,        view,           {0} },
  { ClkTagBar,            0,                   Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,              Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,              Button3,        toggletag,      {0} },
  { ClkTagBar,		0,		     Button4,	     shiftview,      {.i = -1} },
  { ClkTagBar,		0,		     Button5,	     shiftview,      {.i = 1} },
  { ClkRootWin,		0,		     Button2,	     togglebar,      {0} },
};

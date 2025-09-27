/* See LICENSE file for copyright and license details */

/* appearance */
static const int borderpx  = 2;        /* border pixel of windows */
static const float mfact   = 0.55;     /* factor of master area size [0.05..0.95] */
static const int nmaster   = 1;        /* number of clients in master area */
static const int resizehints = 0;      /* 1 means respect size hints in tiled resizals */

/* modifier key */
#define MODKEY WLR_MODIFIER_LOGO  /* Super key */

/* commands */
static const char *termcmd[]  = { "alacritty", NULL };
static const char *menucmd[]  = { "bemenu-run", NULL };
static const char *browsercmd[] = { "firefox", NULL };
static const char *lockcmd[] = { "swaylock", NULL };

/* key definitions */
#define TAGKEYS(KEY,TAG) \
	{ MODKEY, KEY, view, {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, KEY, tag, {.ui = 1 << TAG} }

static const struct key keys[] = {
	/* modifier                     key              function        argument */
	{ MODKEY,                       XKB_KEY_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XKB_KEY_d,      spawn,          {.v = menucmd } },
	{ MODKEY,                       XKB_KEY_w,      spawn,          {.v = browsercmd } },
	{ MODKEY|WLR_MODIFIER_SHIFT,    XKB_KEY_q,      quit,           {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT,    XKB_KEY_c,      killclient,     {0} },

	{ MODKEY,                       XKB_KEY_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XKB_KEY_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XKB_KEY_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XKB_KEY_l,      setmfact,       {.f = +0.05} },

	{ MODKEY,                       XKB_KEY_Tab,    view,           {0} },
	{ MODKEY,                       XKB_KEY_space,  togglefloating, {0} },

	/* tagging */
	TAGKEYS( XKB_KEY_1, 0)
	TAGKEYS( XKB_KEY_2, 1)
	TAGKEYS( XKB_KEY_3, 2)
	TAGKEYS( XKB_KEY_4, 3)
	TAGKEYS( XKB_KEY_5, 4)
	TAGKEYS( XKB_KEY_6, 5)
	TAGKEYS( XKB_KEY_7, 6)
	TAGKEYS( XKB_KEY_8, 7)
	TAGKEYS( XKB_KEY_9, 8)

	{ MODKEY,                       XKB_KEY_0,      view,           {.ui = ~0 } },
};

/* button definitions (mouse) */
static const struct button buttons[] = {
	/* modifier         button        function        argument */
	{ MODKEY,           BTN_LEFT,     movemouse,      {0} },
	{ MODKEY,           BTN_MIDDLE,   togglefloating, {0} },
	{ MODKEY,           BTN_RIGHT,    resizemouse,    {0} },
};


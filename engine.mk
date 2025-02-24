
# List all of your C files here, but change the extension to ".c"
# Include "romdisk.c" if you want a rom disk.

XASH_CLIENT_SRCS = \
	engine/client/vgui/vgui_draw.c \
	engine/client/avi/avi_stub.c \
	engine/client/cl_cmds.c \
	engine/client/cl_custom.c \
	engine/client/cl_debug.c \
	engine/client/cl_demo.c \
	engine/client/cl_efrag.c \
	engine/client/cl_efx.c \
	engine/client/cl_events.c \
	engine/client/cl_font.c \
	engine/client/cl_frame.c \
	engine/client/cl_game.c \
	engine/client/cl_gameui.c \
	engine/client/cl_main.c \
	engine/client/cl_mobile.c \
	engine/client/cl_netgraph.c \
	engine/client/cl_parse.c \
	engine/client/cl_parse_48.c \
	engine/client/cl_qparse.c \
	engine/client/cl_pmove.c \
	engine/client/cl_remap.c \
	engine/client/cl_render.c \
	engine/client/cl_scrn.c \
	engine/client/cl_securedstub.c \
	engine/client/cl_tent.c \
	engine/client/cl_video.c \
	engine/client/cl_view.c \
	engine/client/console.c \
	engine/client/gamma.c \
	engine/client/in_joy.c \
	engine/client/in_touch.c \
	engine/client/input.c \
	engine/client/keys.c \
	engine/client/mod_dbghulls.c \
	engine/client/ref_common.c \
	engine/client/s_dsp.c \
	engine/client/s_load.c \
	engine/client/s_main.c \
	engine/client/s_mix.c \
	engine/client/s_mouth.c \
	engine/client/s_stream.c \
	engine/client/s_utils.c \
	engine/client/s_vox.c \
	engine/client/titles.c \
	engine/client/vid_common.c \
	engine/client/voice.c \

XASH_SRCS = \
	engine/common/base_cmd.c \
	engine/common/cfgscript.c \
	engine/common/cmd.c \
	engine/common/common.c \
	engine/common/con_utils.c\
	engine/common/custom.c \
	engine/common/cvar.c \
	engine/common/dedicated.c \
	engine/common/filesystem_engine.c \
	engine/common/munge.c \
	engine/common/host.c \
	engine/common/host_state.c\
	engine/common/hpak.c\
	engine/common/imagelib/img_bmp.c \
	engine/common/imagelib/img_dds.c \
	engine/common/imagelib/img_ktx2.c \
	engine/common/imagelib/img_main.c \
	engine/common/imagelib/img_png.c \
	engine/common/imagelib/img_quant.c \
	engine/common/imagelib/img_tga.c \
	engine/common/imagelib/img_utils.c \
	engine/common/imagelib/img_wad.c \
	engine/common/infostring.c \
	engine/common/ipv6text.c \
	engine/common/launcher.c \
	engine/common/lib_common.c \
	engine/common/masterlist.c \
	engine/common/mod_alias.c\
	engine/common/mod_bmodel.c\
	engine/common/mod_sprite.c \
	engine/common/mod_studio.c \
	engine/common/model.c \
	engine/common/net_buffer.c \
	engine/common/net_chan.c \
	engine/common/net_encode.c \
	engine/common/pm_surface.c \
	engine/common/pm_trace.c \
	engine/common/soundlib/snd_utils.c \
	engine/common/sounds.c \
	engine/common/sys_con.c \
	engine/common/system.c \
	engine/common/world.c \
	engine/common/zone.c \
	public/build.c \
	public/build_vcs.c \
	public/crclib.c \
	public/crtlib.c \
	public/matrixlib.c \
	public/utflib.c \
	public/xash3d_mathlib.c \
	public/miniz.c

XASH_SERVER_SRCS =	\
	engine/server/sv_client.c \
	engine/server/sv_cmds.c \
	engine/server/sv_custom.c \
	engine/server/sv_filter.c \
	engine/server/sv_frame.c \
	engine/server/sv_game.c \
	engine/server/sv_init.c \
	engine/server/sv_log.c \
	engine/server/sv_main.c \
	engine/server/sv_move.c \
	engine/server/sv_phys.c \
	engine/server/sv_pmove.c \
	engine/server/sv_query.c \
	engine/server/sv_save.c \
	engine/server/sv_world.c \
	
XASH_PLATFORM_SRCS = \
	engine/platform/posix/lib_posix.c \
	engine/platform/posix/sys_posix.c \
	engine/platform/stub/s_stub.c \

XASH_FS_DSO_SRCS = \
	fs_system/dir.c \
	fs_system/filesystem.c \
	fs_system/pak.c \
	fs_system/VFileSystem009.c \
	fs_system/wad.c \
	fs_system/zip.c

INCLUDE = -Icommon \
-Iengine/server \
-Iengine/client/vgui \
-Iengine/client/avi \
-Iengine/client \
-Iengine \
-Iengine/common \
-Iimagelib \
-Ifs_system \
-Ipublic \
-Ipm_shared \
-Iengine/platform \
-ISDL \

DEFINES =  -DXASH_DEDICATED -DHAVE_STRICMP -DHAVE_STRCASECMP -DXASH_NO_NETWORK -D__vr4300__ -D__BIG_ENDIAN__ -DSTDINT_H='<stdint.h>' -DENGINE_DLL -DXASH_BUILD_COMMIT="64726f13-dirty" -DXASH_BUILD_BRANCH="master" -DXASH_LOW_MEMORY=1 -DXASH_ENABLE_MAIN=1 -DDBGHELP=1 -DPSAPI_VERSION=1 -DXASH_REF_SOFT_ENABLED=1 -DXASH_REF_GL_ENABLED=0 -D_CRT_SILENCE_NONCONFORMING_TGMATH_H=1 -DHAVE_TGMATH_H=0 -DHAVE_STRNICMP=1
FLAGS = -Wall -w -Wextra -Wformat=0 -Wno-missing-field-initializers -Wdouble-promotion  -fsingle-precision-constant -Xlinker -Map=output.map -Wno-error=sign-compare -Wno-error=double-promotion -Wno-error=address
#CFLAGS +=  $(INCLUDE) $(DEFINES) $(FLAGS)
#CXXFLAGS += $(INCLUDE) $(DEFINES) $(CFLAGS) -fno-exceptions -std=gnu++11 -fpermissive  -MMD -MP

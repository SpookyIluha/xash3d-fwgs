BUILD_DIR=build
include $(N64_INST)/include/n64.mk

DEFINES =  -DXASH_DEDICATED -DHAVE_STRICMP -DHAVE_STRCASECMP -DXASH_NO_NETWORK -D__vr4300__ -D__BIG_ENDIAN__ -DSTDINT_H='<stdint.h>' -DENGINE_DLL -DXASH_BUILD_COMMIT="64726f13-dirty" -DXASH_BUILD_BRANCH="master" -DXASH_LOW_MEMORY=1 -DXASH_ENABLE_MAIN=1 -DDBGHELP=1 -DPSAPI_VERSION=1 -DXASH_REF_SOFT_ENABLED=1 -DXASH_REF_GL_ENABLED=0 -D_CRT_SILENCE_NONCONFORMING_TGMATH_H=1 -DHAVE_TGMATH_H=0 -DHAVE_STRNICMP=1
FLAGS = -Wall -w -Wextra -Wformat=0 -Wno-missing-field-initializers -Wdouble-promotion  -fsingle-precision-constant -Xlinker -Map=output.map -Wno-error=sign-compare -Wno-error=double-promotion -Wno-error=address

main_SRC = dir.c filesystem.c pak.c VFileSystem009.c wad.c link_helper.c

circle_SRC = circle.c
triangle_SRC = triangle.c
n64brew_SRC = n64brew.c

assets_png = $(wildcard assets/*.png)
assets_conv = $(addprefix filesystem/,$(notdir $(assets_png:%.png=%.sprite)))

all: overlays_actor.z64

MAIN_ELF_EXTERNS := $(BUILD_DIR)/overlays_actor.externs
DSO_MODULES = circle.dso triangle.dso n64brew.dso
DSO_LIST = $(addprefix filesystem/, $(DSO_MODULES))

filesystem/%.sprite: assets/%.png
	@mkdir -p $(dir $@)
	@echo "    [SPRITE] $@"
	@$(N64_MKSPRITE) -f RGBA16 --compress -o "$(dir $@)" "$<"
    
$(BUILD_DIR)/overlays_actor.dfs: $(assets_conv) $(DSO_LIST)
$(BUILD_DIR)/overlays_actor.elf: $(main_SRC:%.c=$(BUILD_DIR)/%.o) $(MAIN_ELF_EXTERNS)
$(MAIN_ELF_EXTERNS): $(DSO_LIST)
filesystem/circle.dso: $(circle_SRC:%.c=$(BUILD_DIR)/%.o)
filesystem/triangle.dso: $(triangle_SRC:%.c=$(BUILD_DIR)/%.o)
filesystem/n64brew.dso: $(n64brew_SRC:%.c=$(BUILD_DIR)/%.o)

overlays_actor.z64: N64_ROM_TITLE="Actor Overlay Demo"
overlays_actor.z64: $(BUILD_DIR)/overlays_actor.dfs $(BUILD_DIR)/overlays_actor.msym

$(BUILD_DIR)/overlays_actor.msym: $(BUILD_DIR)/overlays_actor.elf

clean:
	rm -rf $(BUILD_DIR) filesystem $(DSO_LIST) overlays_actor.z64

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean

# Put the filename of the output binary here
PROJECT_NAME = xash
TARGET = xash.elf

include engine.mk

OBJS =  $(XASH_OBJS) $(XASH_SERVER_OBJS) 
#LIBS = -L../hlsdk-portable_dc/dlls -L../hlsdk-portable_dc/cl_dll -Ldfsfolder -L$(KOS_BASE)/addons/lib/$(KOS_ARCH) -L$(KOS_PORTS)/lib -Lref/gldc -lSDL_gl -lm  -ldfsfolder_stdio -lhl -lcl_dll -lref_gldc -l:libGL.a 

# Directories

BUILD_DIR=build

include $(N64_INST)/include/n64.mk

# File aggregators
SRCS := $(XASH_SRCS) $(XASH_SERVER_SRCS) $(XASH_PLATFORM_SRCS)

N64_CXXFLAGS += $(INCLUDE) $(DEFINES) $(FLAGS) -std=gnu++11 -fpermissive -DXASH_MIPS=1 -D__mips__=1
N64_CFLAGS   += $(INCLUDE) $(DEFINES) $(FLAGS) -DXASH_N64=1


# Compiler Flags
#KOS_CPPSTD	:= -std=c++20
#LDLIBS 		:= -lstb_image -lGL -lkmg -lkosutils -lwav

assets_png = $(wildcard assets/textures/*.png)
assets_wav = $(wildcard assets/audios/*.wav)
assets_stl = $(wildcard assets/stls/*.stl)
assets_xyzuv = $(wildcard assets/xyzuv/*.xyzuv)
assets_fonts = $(wildcard assets/fonts/*.ttf)

assets_conv = $(addprefix dfsfolder/textures/,$(notdir $(assets_png:%.png=%.sprite))) \
			  $(addprefix dfsfolder/audios/,$(notdir $(assets_wav:%.wav=%.wav64))) \
			  $(addprefix dfsfolder/stls/,$(notdir $(assets_stl:%.stl=%.stl))) \
			  $(addprefix dfsfolder/xyzuv/,$(notdir $(assets_xyzuv:%.xyzuv=%.xyzuv))) \
			  $(addprefix dfsfolder/fonts/,$(notdir $(assets_fonts:%.ttf=%.font64))) 

all: Xash64.z64

dfsfolder/textures/%.sprite: assets/textures/%.png
	@mkdir -p $(dir $@)
	@echo "    [SPRITE] $@"
	$(N64_MKSPRITE) $(MKSPRITE_FLAGS) -d -o dfsfolder/textures "$<"

dfsfolder/stls/%.stl: assets/stls/%.stl
	@mkdir -p $(dir $@)
	@echo "    [STL] $@"
	cp "$<" $@

dfsfolder/xyzuv/%.xyzuv: assets/xyzuv/%.xyzuv
	@mkdir -p $(dir $@)
	@echo "    [XYZUV] $@"
	cp "$<" $@

dfsfolder/audios/%.wav64: assets/audios/%.wav
	@mkdir -p $(dir $@)
	@echo "    [AUDIO] $@"
	@$(N64_AUDIOCONV) --wav-compress 1 -o dfsfolder/audios $<

dfsfolder/fonts/%.font64: assets/fonts/%.ttf
	@mkdir -p $(dir $@)
	@echo "    [FONT] $@"
	$(N64_MKFONT) $(MKFONT_FLAGS) -o dfsfolder/fonts "$<"


$(BUILD_DIR)/Xash64.dfs: $(assets_conv)
$(BUILD_DIR)/Xash64.elf: $(SRCS:%.c=$(BUILD_DIR)/%.o)

Xash64.z64: N64_ROM_TITLE="Xash 64 Build"
Xash64.z64: $(BUILD_DIR)/Xash64.dfs

clean:
	rm -rf $(BUILD_DIR) *.z64
	rm -rf dfsfolder

build_lib:
	rm -rf $(BUILD_DIR) *.z64
	make -C $(T3D_INST)
	make all

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean
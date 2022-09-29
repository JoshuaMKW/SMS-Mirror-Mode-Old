#=======================#
#/*\/\/\/\/\/\/\/\/\/\*/#
#                       #
# Written for PyiiASMH3 #
# --------------------- #
# To compile, take each #
#  section and compile  #
#    it individually    #
# with the header info. #
# --------------------- #
#        JoshuaMK       #
#                       #
#/*/\/\/\/\/\/\/\/\/\/*/#
#=======================#


#--------------------#
# Header Information #
#--------------------#

.set JAPAN2, 'Z'

.set __region__, AMERICA
# .set __region__, EUROPE
# .set __region__, JAPAN
# .set __region__, JAPAN2

.set __xyz__, 0x800003E0  # {-1.0, 1.0, 1.0}

.if __region__ == AMERICA
	.set GXSetCullMode, 0x8035E210
	.set GXSetProjection, 0x80362C34
	.set C_MTXPerspective, 0x8034A404
	.set C_MTXLightPerspective, 0x8034A17C
	.set PSMTXConcat, 0x803499F0
	.set PSMTXScale, 0x80349E44
	.set PSMTXScaleApply, 0x80349E6C
	.set J3DMaterialFactory__newCullMode, 0x802E6224
	.set J3DMaterialFactory_v21__newCullMode, 0x8031F078
	.set JUTGamePad__update, 0x802C8F70
	.set JUTGamePad__CStick__update, 0x802C93EC
    .set JUTGamePad__InputArray, 0x80404456
	.set gpMarDirector, 0x8040E178
.elseif __region__ == EUROPE
	.set GXSetCullMode, 0x80356430
	.set GXSetProjection, 0x8035AE54
	.set C_MTXPerspective, 0x80342660
	.set C_MTXLightPerspective, 0x803423D8
	.set PSMTXConcat, 0x80341C4C
	.set PSMTXScale, 0x803420A0
	.set PSMTXScaleApply, 0x803420C8
	.set J3DMaterialFactory__newCullMode, 0x802DE3CC
	.set J3DMaterialFactory_v21__newCullMode, 0x80317208
	.set JUTGamePad__update, 0x802C1004
	.set JUTGamePad__CStick__update, 0x802C1480
    .set JUTGamePad__InputArray, 0x80404456
	.set gpMarDirector, 0x80405840
.elseif __region__ == JAPAN
	.set GXSetCullMode, 0x8035E210
	.set GXSetProjection, 0x80362C34
	.set C_MTXPerspective, 0x80362C34
	.set C_MTXLightPerspective, 0x8034A404
	.set PSMTXConcat, 0x80362C34
	.set PSMTXScale, 0x80349E44
	.set PSMTXScaleApply, 0x80349E6C
	.set J3DMaterialFactory__newCullMode, 0x802E6224
	.set J3DMaterialFactory_v21__newCullMode, 0x8031F078
	.set JUTGamePad__update, 0x802C8F70
	.set JUTGamePad__CStick__update, 0x802C93EC
    .set JUTGamePad__InputArray, 0x80404456
	.set gpMarDirector, 0x8040E178
.elseif __region__ == JAPAN2
	.set GXSetCullMode, 0x800A8B30
	.set GXSetProjection, 0x800AD554
	.set C_MTXPerspective, 0x80094D24
	.set C_MTXLightPerspective, 0x80094A9C
	.set PSMTXConcat, 0x80094310
	.set PSMTXScale, 0x80094764
	.set PSMTXScaleApply, 0x8009478C
	.set J3DMaterialFactory__newCullMode, 0x8002FD88
	.set J3DMaterialFactory_v21__newCullMode, 0x80069950
	.set JUTGamePad__update, 0x80011FAC
	.set JUTGamePad__CStick__update, 0x80012428
    .set JUTGamePad__InputArray, 0x80404456
	.set gpMarDirector, 0x8040A2A8
.else
	.abort
.endif
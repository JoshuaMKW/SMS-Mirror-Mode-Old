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


.include "sms_mirror_mode_header.s"

#------------------#
# Create XYZ Scale #
#------------------#

#inject(__xyz__)

.float -1.0, 1.0, 1.0


#----------------------#
# Mirror GX Projection #
#----------------------#

#inject(0x800233A4)  # AMERICA
# #inject(0x800233A4)  # EUROPE
# #inject(0x800233A4)  # JAPAN
# #inject(0x800233A4)  # JAPAN2
	
# START #

__push_stack r29, 0x20, TRUE
mr r29, r3
mr r30, r4

# Get MTX scale
__set r31, __xyz__
lfs f1, 0 (r31)
lfs f2, 4 (r31)
lfs f3, 8 (r31)

# Scale MTX
mr r4, r3
__call r12, PSMTXScaleApply

# Apply projection MTX
mr r3, r29
mr r4, r30
__call r12, GXSetProjection

default:
__pop_stack r29, 0x20, TRUE


# END #


#------------------------#
# Mirror J3D Culling v26 #
#------------------------#

#inject(0x802E570C)  # AMERICA
# #inject(0x802E570C)  # EUROPE
# #inject(0x802E570C)  # JAPAN
# #inject(0x802E570C)  # JAPAN2
	
# START #

__push_stack r29, 0x20, TRUE

# Generate the cull mode
__call r12, J3DMaterialFactory__newCullMode

lis r4, gpMarDirector@ha
lwz r4, gpMarDirector@l (r4)
cmpwi r4, 0
beq default  # Not in a level

cmpwi r3, 1
beq set_2    # Convert FRONT to BACK

cmpwi r3, 2
bne default  # Neither BACK nor FRONT

li r3, 1     # Set to BACK
b default

set_2:
li r3, 2     # Set to FRONT

default:
__pop_stack r29, 0x20, TRUE


# END #



#------------------------#
# Mirror J3D Culling v21 #
#------------------------#

#inject(0x8031E7C8)  # AMERICA
# #inject(0x8031E7C8)  # EUROPE
# #inject(0x8031E7C8)  # JAPAN
# #inject(0x8031E7C8)  # JAPAN2
	
# START #

__push_stack r29, 0x20, TRUE

# Generate the cull mode
__call r12, J3DMaterialFactory_v21__newCullMode

lis r4, gpMarDirector@ha
lwz r4, gpMarDirector@l (r4)
cmpwi r4, 0
beq default  # Not in a level

cmpwi r3, 1
beq set_2    # Convert FRONT to BACK

cmpwi r3, 2
bne default  # Neither BACK nor FRONT

li r3, 1     # Set to BACK
b default

set_2:
li r3, 2     # Set to FRONT

default:
__pop_stack r29, 0x20, TRUE


# END #


#-------------------#
# Mirror GX Culling #
#-------------------#

#inject(GXSetCullMode)  # AMERICA
# #inject(GXSetCullMode)  # EUROPE
# #inject(GXSetCullMode)  # JAPAN
# #inject(GXSetCullMode)  # JAPAN2
	
# START #

li r3, 0  # Force no culling
cmpwi r3, 2
__branch r12, GXSetCullMode + 4

# END #


#----------------------------------#
# Mirror Light Perspective Effects #
#----------------------------------#

#inject(0x8022BA9C)  # AMERICA
# #inject(0x8022BA9C)  # EUROPE
# #inject(0x8022BA9C)  # JAPAN
# #inject(0x8022BA9C)  # JAPAN2
	
# START #

__push_stack r30, 0x8, TRUE
mr r30, r3

__call r12, C_MTXPerspective

# Get MTX scale
__set r31, __xyz__
lfs f1, 0 (r31)
lfs f2, 4 (r31)
lfs f3, 8 (r31)

# Scale MTX
mr r3, r30
mr r4, r30
__call r12, PSMTXScaleApply

mr r3, r30

default:
__pop_stack r30, 0x8, TRUE


# END #

#--------------------#
# Mirror Reflections #
#--------------------#

#inject(0x800003B0)
	
# START #

__push_stack r28, 0x20, TRUE
mr r28, r3
mr r29, r4
mr r30, r5

# Get MTX scale
__set r31, __xyz__
lfs f1, 0 (r31)
lfs f2, 4 (r31)
lfs f3, 8 (r31)

# Scale MTX
mr r3, r4
__call r12, PSMTXScaleApply

# Apply projection MTX
mr r3, r28
mr r4, r29
mr r5, r30
__call r12, PSMTXConcat

mr r3, r28

default:
__pop_stack r28, 0x20, TRUE

blr

# END #


#----------------------------#
# Mirror Droplet Reflections #
#----------------------------#

#inject(0x8027C1F0)  # AMERICA
# #inject(0x8027C1F0)  # EUROPE
# #inject(0x8027C1F0)  # JAPAN
# #inject(0x8027C1F0)  # JAPAN2
	
# START #

__push_stack r29, 0x50, TRUE
addi r29, r1, 0x20
mr r30, r3

__call r12, C_MTXLightPerspective

# Get MTX scale
__set r31, __xyz__
lfs f1, 0 (r31)
lfs f2, 4 (r31)
lfs f3, 8 (r31)

# Scale MTX
mr r3, r29
__call r12, PSMTXScale

# Apply projection MTX
mr r3, r30
mr r4, r29
mr r5, r30
__call r12, PSMTXConcat

mr r3, r30

default:
__pop_stack r29, 0x50, TRUE


# END #


#-------------------------#
# Mirror Controller Input #
#-------------------------#

#inject(0x802C8E54)  # AMERICA
# #inject(0x8027C1F0)  # EUROPE
# #inject(0x8027C1F0)  # JAPAN
# #inject(0x8027C1F0)  # JAPAN2


.set CTRL_STICK_X, 0
.set CTRL_STICK_Y, 1
.set C_STICK_X, 2
.set C_STICK_Y, 3

.set CTRL_STICK_KIND, 0
.set C_STICK_KIND, 1
.set CONTROLLER_STATUS, 10
.set INPUT_ARRAY_SIZE, 12
	
# START #

__push_stack r26, 0x30, TRUE
mr r30, r3

__call r12, JUTGamePad__update

lis r31, gpMarDirector@ha
lwz r31, gpMarDirector@l (r31)
cmpwi r31, 0
beq exit  # Not in a level

lbz r0, 0x64 (r31)  # Get game status
cmpwi r0, 10        # Is game paused
beq exit

lha r27, 0x78 (r30)
cmpwi r27, -1
beq exit

__set r28, JUTGamePad__InputArray
slwi r26, r27, INPUT_ARRAY_SIZE
add r26, r28, r26

addi r3, r30, 72
lbz r4, CTRL_STICK_X (r26)
neg r4, r4
lbz r5, CTRL_STICK_Y (r26)
li r6, 1
li r7, CTRL_STICK_KIND
__call r12, JUTGamePad__CStick__update

addi r3, r30, 88
lbz r4, C_STICK_X (r26)
neg r4, r4
lbz r5, C_STICK_Y (r26)
li r6, 1
li r7, C_STICK_KIND
__call r12, JUTGamePad__CStick__update

exit:
__pop_stack r26, 0x30, TRUE


# END #


#-------------------------#
# Mirror Controller Input #
#-------------------------#

#inject(0x802cba44)  # AMERICA
# #inject(0x8027C1F0)  # EUROPE
# #inject(0x8027C1F0)  # JAPAN
# #inject(0x8027C1F0)  # JAPAN2

802cba44
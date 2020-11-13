# 5-axis-delta
5-axis 3d printer concept using composite delta geometry

Work (almost) in progress...  Exploring a concept for a 5-axis 3D Printer on the cheap.

The starting point is a basic delta printer geometry, however we will add an additional 2 independently controlled carriages to the existing towers which will actuate a second delta system to orient the hot-end which will pivot in a "high misalignment" spherical bearing in the existing effector where rotation and play will be constrained by springs.

I'll be starting with a CloverPlusV2 by pbmax as I have most of the required parts on hand. A Duet 3 reproduction controller to allow control of 6 independent axis (3 for the base delta, 2 additional and extruder) which will be mounted symmetrically top and bottom (printing two Clover "bottom" pieces for the frame).

This work will possibly include custom kinematics for the RepRapFirmware or kinematics baked into some sample G-Code depending on how promising initial tests are.

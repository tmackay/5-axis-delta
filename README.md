# 5-axis-delta
5-axis 3d printer concept using composite delta geometry

Work (almost) in progress...  Exploring a concept for a 5-axis 3D Printer on the cheap.

The starting point is a basic delta printer geometry, however we will add an additional 2 independently controlled carriages to the existing towers which will actuate a second delta system to orient the hot-end which will pivot in a "high misalignment" spherical bearing in the existing effector where rotation and play will be constrained by a spring.

I'll be starting with a CloverPlusV2 by pbmax as I have most of the required parts on hand. A Duet 3 reproduction controller to allow control of 6 independent axis (3 for the base delta, 2 additional and extruder) which will be mounted symmetrically top and bottom (printing two Clover "bottom" pieces for the frame).

This work will possibly include custom kinematics for the RepRapFirmware or kinematics baked into some sample G-Code depending on how promising initial tests are.

Freedom of movement of the axis will be quite limited in comparison to conventional 5-axis machines and primarily aims to allow printing overhangs of 90 degrees by tilting the nozzle up to 45 degrees from vertical. Improved top surface strength and finish might also be achieved by following surface contours.

The goals of this project are to demonstrate that 5-axis printers are viable for the low budget hobbyist and hopefully spur interest in further developing slicing techniques to suit.

![frame](https://raw.githubusercontent.com/tmackay/5-axis-delta/main/frame.jpg)

For the hotend I am leaning towards something akin to the Thermoplast 2:
![Thermoplast Extruder 2.0](https://reprap.org/mediawiki/images/thumb/a/ad/ThermoplastExtruder_2_0-wound-heater.jpg/300px-ThermoplastExtruder_2_0-wound-heater.jpg)

Press-fit into a spherical bearing with a suitable ball terminated control arm:
![Spherical Bearing](https://media.rs-online.com/t_large/F4884903-01.jpg)

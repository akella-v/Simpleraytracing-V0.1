# Simpleraytracing-V0.1
/** Author: Akella Venkata Anish**/
/**Language: CUDA*/
Objective -- A simpler version on Parallel Ray Tracing and its implementation.

Using the understanding of Ray tracing along with concepts from other sources, this module has been coded in CUDA. This code does the following:
a) Generating Scalable Spheres with a fixed weightage on random instants using “rand() Function” on a grayscale 2D canvas.
b) Using multiple 3D vector points to create rays where their Z co-ordinate is fixed (So that the generated rays seem to be in 2D).
c) Finding the points of intersection and points expected to be illuminated by this ray. Adding the concept of light dispersion to illuminate multiple points of sphere which fall in the light radius of the rays.
d) Making sure the correct side of the spheres are illuminated.
e) Introducing reflections and dispersion to all of the multiple rays.
f) Using “GPROF” to profile the serial C Code to understand which section of the loop to be parallelized.
g) CUDA Implementation on the C program.
h) Using “NVPROF” to understand the efficiency of the CUDA code and it it was efficient on HIPER GATOR.
i) Proper benchmarking and testing with a variety of canvas sizes and number of spheres.

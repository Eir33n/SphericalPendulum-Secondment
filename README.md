# Spherical Pendulum
## Project collaboration MLU - NTNU
### Model
The code in MATLAB solves the spherical pendulum with the following equations:
$$\begin{cases}
\dot{q}=\omega\times q\\
\dot{\omega}=ge_3\times q-c\omega
\end{cases}$$
where $(q,\omega)\in TS^2$ in the vector of unknown, $g$ is the gravitational acceleration and $c$ is the damping parameter of the pendulum.

### Code
#### MATLAB
The main file is called `a_main` and comprehend the solution and the analysis of the results.
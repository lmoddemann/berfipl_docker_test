model MassSpringDamper
  parameter Real m = 1 "Mass (kg)";
  parameter Real k = 100 "Spring constant (N/m)";
  parameter Real d = 5 "Damping coefficient (Ns/m)";
  parameter Real x0 = 0.1 "Initial position (m)";
  parameter Real v0 = 0 "Initial velocity (m/s)";
  
  Real x "Position (m)";
  Real v "Velocity (m/s)";

equation
  m*der(v) = -k*x - d*v;  // Force equation
  m*der(x) = v;           // Velocity equation

initial equation
  x = x0;  // Initial condition for position
  v = v0;  // Initial condition for velocity
end MassSpringDamper;

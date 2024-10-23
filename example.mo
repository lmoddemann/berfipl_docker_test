model spring_damper
  // Parameters
  parameter Real m = 1 "Mass (kg)";
  parameter Real k = 10 "Spring constant (N/m)";
  parameter Real d = 1 "Damping coefficient (Ns/m)";
  
  // States
  Real x(start = 0); // Position (m)
  Real v(start = 0); // Velocity (m/s)

equation
  // State equations
  m * der(v) = -k * x - d * v;  // Force balance on the mass
  der(x) = v;                   // Velocity is the derivative of position

end spring_damper;

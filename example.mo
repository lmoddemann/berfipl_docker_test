model MassSpringDamper
  parameter Real m = 1.0 "Mass (kg)";
  parameter Real k = 100.0 "Spring constant (N/m)";
  parameter Real d = 5.0 "Damping coefficient (Ns/m)";
  parameter Real x0 = 0.1 "Initial position (m)";
  parameter Real v0 = 0.0 "Initial velocity (m/s)";

  Real x "Position (m)";
  Real v "Velocity (m/s)";

  initial equation
    x = x0;
    v = v0;

  equation
    m * der(v) = -(k * x + d * v);
    m * der(x) = v;

  // Add output statements
  when sample(0, 0.1) then // Sample every 0.1 seconds
    Modelica.Utilities.Streams.print("Time: " + String(time) + ", Position: " + String(x) + ", Velocity: " + String(v));
  end when;

end MassSpringDamper;

model Test
  MassSpringDamper ms;
  
  // Experiment settings
  experiment(StopTime=10);
end Test;

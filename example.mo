model MassSpringDamper
  // Parameters for mass-spring-damper system
  parameter Real m = 1.0 "Mass (kg)";
  parameter Real k = 100.0 "Spring constant (N/m)";
  parameter Real d = 5.0 "Damping coefficient (Ns/m)";
  parameter Real x0 = 0.1 "Initial position (m)";
  parameter Real v0 = 0.0 "Initial velocity (m/s)";
  
  // State variables for position and velocity
  Real x "Position (m)";
  Real v "Velocity (m/s)";
  
  // Variables to store simulation results
  output Real time_out;
  output Real x_out;
  output Real v_out;
  
  // Initial conditions
  initial equation
    x = x0;
    v = v0;
  
  // Main equations of motion
  equation
    m * der(v) = -(k * x + d * v);
    m * der(x) = v;
  
  // Collect results for output
  when time >= 0.0 then
    time_out = time;
    x_out = x;
    v_out = v;
  end when;

end MassSpringDamper;

// Wrapper model to simulate and write results to a file
model Test
  MassSpringDamper ms; // Instance of the MassSpringDamper model

  // Simulation settings
  experiment(StopTime=10); // Define the simulation stop time

  // Output file declaration
  output Real time_out;
  output Real x_out;
  output Real v_out;

  // Connect the results to the outputs
  equation
    time_out = ms.time_out;
    x_out = ms.x_out;
    v_out = ms.v_out;

  // After simulation, print results
  when final() then
    Modelica.Utilities.Streams.print("Simulation Results:");
    Modelica.Utilities.Streams.print("Time (s), Position (m), Velocity (m/s)");
    for i in 0:100 loop
      Modelica.Utilities.Streams.print(String(i/10) + ", " + String(x_out) + ", " + String(v_out));
    end for;
  end when;
end Test;

## rain-tank-disinfection
This model explores options to simulate and systematically control chlorine disinfection in off-grid rainwater tanks for potable water use to ensure compliant levels (between 0.5 to 5ppm because too much may form cancerous trihalomethanes while too little may not ensure disinfection). 

The advection-diffusion-reaction (ADR) equation (aka convection-diffusion-reaction), is a parabolic PDE that can be used to model the evolution of chlorine concentrations.

First, a model was developed in Matlab assuming a contact time of 5 minutes. A diameter of 1-1/2” and flow of 1.5 gpm was assumed. A length of 25 meters was set to ensure contact time. Then the model advanced model was revised based on an assumed flow schedule, varying throughout the day. For this more flow scenario, it may be difficult to ensure concentration at the end point is at a desire level, so a proportional feedback controller was used to control the chlorine dosage 

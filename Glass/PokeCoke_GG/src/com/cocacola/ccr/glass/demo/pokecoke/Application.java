package com.cocacola.ccr.glass.demo.pokecoke;

import com.parse.Parse;

public class Application extends android.app.Application
{

	public Application()
	{}

	@Override
	public void onCreate()
	{
		super.onCreate();

		// Initialize the Parse SDK.
		Parse.initialize(this, "0QymSGRy3Bn435UbWnlCdw2mm397vj9Clyse5R9L", "2EL4PcAB8TaIjG2EX0sadt2PmtaBsBrYNOORuObq");

		
	}
}
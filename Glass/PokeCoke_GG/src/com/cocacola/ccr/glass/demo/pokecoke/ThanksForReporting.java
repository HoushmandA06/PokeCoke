/*
 * Copyright (C) 2014 The Android Open Source Project Licensed under the Apache
 * License, Version 2.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0 Unless required by applicable law
 * or agreed to in writing, software distributed under the License is
 * distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */

package com.cocacola.ccr.glass.demo.pokecoke;

import android.app.Activity;
import android.content.Context;
import android.media.AudioManager;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.widget.TextView;

import com.google.android.glass.media.Sounds;
import com.google.android.glass.touchpad.Gesture;
import com.google.android.glass.touchpad.GestureDetector;
import com.parse.ParseObject;

/**
 * The concrete, non-tutorial implementation of the game: one minute long with
 * ten randomly selected phrases.
 */
public class ThanksForReporting extends Activity
{

	/** TextView that displays the amount of time remaining in the game. */
	private TextView mProductName;

	private AudioManager mAudioManager;
	private String mDeviceLat = "";
	private String mDeviceLong = "";

	/** Listener that displays the options menu when the touchpad is tapped. */
	private final GestureDetector.BaseListener mBaseListener = new GestureDetector.BaseListener()
	{
		@Override
		public boolean onGesture(Gesture gesture)
		{
			if (gesture == Gesture.TAP)
			{
				mAudioManager.playSoundEffect(Sounds.TAP);
				finish();
				return true;
			}
			else
			{
				return false;
			}
		}
	};

	/** Gesture detector used to present the options menu. */
	private GestureDetector mGestureDetector;

	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		mAudioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
		mGestureDetector = new GestureDetector(this).setBaseListener(mBaseListener);
		
		setContentView(R.layout.productresult);
		mProductName = (TextView) findViewById(R.id.product_name);
		((TextView) findViewById(R.id.tip_tap_for_options)).setText("");

		mProductName.setText("Thanks for the info!  Expect a reward email in your inbox!");
	}

	@Override
	public boolean onGenericMotionEvent(MotionEvent event)
	{
		return mGestureDetector.onMotionEvent(event);
	}

	

}

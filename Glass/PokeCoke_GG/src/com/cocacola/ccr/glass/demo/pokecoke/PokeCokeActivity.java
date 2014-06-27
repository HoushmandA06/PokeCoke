/*
 * Copyright (C) 2013 The Android Open Source Project Licensed under the Apache
 * License, Version 2.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0 Unless required by applicable law
 * or agreed to in writing, software distributed under the License is
 * distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */

package com.cocacola.ccr.glass.demo.pokecoke;

import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.media.AudioManager;
import android.os.Bundle;
import android.speech.RecognizerIntent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;

import com.google.android.glass.media.Sounds;
import com.google.android.glass.touchpad.Gesture;
import com.google.android.glass.touchpad.GestureDetector;

/**
 * Activity showing the search coke options menu.
 */
public class PokeCokeActivity extends Activity implements LocationListener
{

	private static final int SPEECH_REQUEST = 0;
	

	private AudioManager mAudioManager;

	private String spokenText = "";

	private LocationManager locationManager;
	private String mDeviceLat = "";
	private String mDeviceLong = "";
	private Context mContext;

	/** Listener that displays the options menu when the touchpad is tapped. */
	private final GestureDetector.BaseListener mBaseListener = new GestureDetector.BaseListener()
	{
		@Override
		public boolean onGesture(Gesture gesture)
		{
			if (gesture == Gesture.TAP)
			{
				mAudioManager.playSoundEffect(Sounds.TAP);
				openOptionsMenu();
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
		mContext = getApplicationContext();

		setContentView(R.layout.pokecoke);

		locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);

		Criteria criteria = new Criteria();
		criteria.setAccuracy(Criteria.ACCURACY_FINE);
		criteria.setAltitudeRequired(true);

		List<String> providers = locationManager.getProviders(criteria, true /* enabledOnly */);

		for (String provider : providers)
		{
			locationManager.requestLocationUpdates(provider, 1000, 10, this);
		}

	}

	private void displaySpeechRecognizer()
	{
		Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
		startActivityForResult(intent, SPEECH_REQUEST);
	}

	@Override
	public boolean onGenericMotionEvent(MotionEvent event)
	{
		return mGestureDetector.onMotionEvent(event);
	}

	@Override
	public boolean onPrepareOptionsMenu(Menu menu)
	{
		super.onPrepareOptionsMenu(menu);

		menu.findItem(R.id.missing_product).setEnabled(true);
		menu.findItem(R.id.no_coke).setEnabled(true);

		return true;
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu)
	{
		super.onCreateOptionsMenu(menu);
		getMenuInflater().inflate(R.menu.pokecoke, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item)
	{
		switch (item.getItemId())
		{
		case R.id.missing_product:

			displaySpeechRecognizer();
			return true;

		case R.id.no_coke:
			startProductMissing();
			return true;

		default:
			return super.onOptionsItemSelected(item);
		}
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data)
	{
		if (requestCode == SPEECH_REQUEST && resultCode == Activity.RESULT_OK)
		{
			List<String> results = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);
			spokenText = results.get(0);
			startProductMissing();
		}

		super.onActivityResult(requestCode, resultCode, data);
	}

	private void startProductMissing()
	{
		Bundle bundle = new Bundle();
		if (!spokenText.isEmpty())
		{
			bundle.putString("ProductName", spokenText);
		}
		else
		{
			bundle.putString("ProductName", "No Product available ");
		}
		bundle.putString("lat", mDeviceLat);
		bundle.putString("long", mDeviceLong);
		Intent intent = new Intent(this, ProductMissing.class);
		intent.putExtras(bundle);
		startActivity(intent);
	}

	

	@Override
	public void onLocationChanged(Location location)
	{
		// device current lat long
		mDeviceLat = String.valueOf(location.getLatitude());
		mDeviceLong = String.valueOf(location.getLongitude());
	}

	@Override
	public void onStatusChanged(String provider, int status, Bundle extras)
	{
		// TODO Auto-generated method stub

	}

	@Override
	public void onProviderEnabled(String provider)
	{
		// TODO Auto-generated method stub

	}

	@Override
	public void onProviderDisabled(String provider)
	{
		// TODO Auto-generated method stub

	}
}

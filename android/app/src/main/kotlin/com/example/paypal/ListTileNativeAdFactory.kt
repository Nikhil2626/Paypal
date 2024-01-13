
import android.app.Activity
import android.view.View
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.example.paypal.R
import com.google.android.gms.ads.VideoController
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class ListTileNativeAdFactory(val context: Activity) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeBannerAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        // Set the media view.
        var adView: NativeAdView = context.layoutInflater.inflate(R.layout.google_native_layout, null) as NativeAdView
//        adView.findViewById(R.id.ad_stars).setVisibility(View.GONE)
        // Set other ad assets.
        val ad_body = adView.findViewById<TextView>(R.id.ad_body);
        var mideaview  = adView!!.findViewById(R.id.ad_media) as com.google.android.gms.ads.nativead.MediaView;
        adView.setMediaView(mideaview);
        adView.setHeadlineView(adView.findViewById(R.id.ad_headline));
        adView.setBodyView(adView.findViewById(R.id.ad_body));
        adView.setCallToActionView(adView.findViewById(R.id.ad_call_to_action));
        adView.setIconView(adView.findViewById(R.id.ad_app_icon));
        adView.setPriceView(adView.findViewById(R.id.ad_price));
        adView.setStarRatingView(adView.findViewById(R.id.ad_stars));
        adView.setStoreView(adView.findViewById(R.id.ad_store));
        adView.setAdvertiserView(adView.findViewById(R.id.ad_advertiser));
        adView.getMediaView()!!.setMediaContent(nativeBannerAd!!.getMediaContent());

        var headline: TextView = adView.getHeadlineView() as TextView
        // The headline and mediaContent are guaranteed to be in every nativeBannerAd.
        headline.setText(nativeBannerAd.getHeadline());
        adView.getMediaView()!!.setMediaContent(nativeBannerAd!!.getMediaContent());

        // These assets aren't guaranteed to be in every nativeBannerAd, so it's important to
        // check before trying to display them.

        if (nativeBannerAd.getBody() == null) {
//            adView.getBodyView().setVisibility(View.INVISIBLE);

            (adView.getBodyView() as TextView).setVisibility(View.GONE);
        } else {
            (adView.getBodyView() as TextView).setVisibility(View.VISIBLE);
            (adView.getBodyView() as TextView).setText(nativeBannerAd.getBody());
        }

        if (nativeBannerAd.getCallToAction() == null) {
//            adView.getCallToActionView().setVisibility(View.INVISIBLE);
            (adView.getCallToActionView() as TextView).setVisibility(View.GONE);
        } else {
            (adView.getCallToActionView() as TextView).setVisibility(View.VISIBLE);
            (adView.getCallToActionView() as TextView).setText(nativeBannerAd.getCallToAction());
//            (adView.getCallToActionView() as TextView).setBackground(context.getResources().getDrawable(R.drawable.btn_ads_blue_btn));
        }

        if (nativeBannerAd.getIcon() == null) {
            (adView.getIconView() as TextView).setVisibility(View.GONE);
        } else {
            (adView.getIconView() as ImageView).setImageDrawable(
                nativeBannerAd.getIcon()!!.getDrawable());
            (adView.getIconView() as ImageView).setVisibility(View.VISIBLE);
        }

        if (nativeBannerAd.getPrice() == null) {
//            adView.getPriceView().setVisibility(View.INVISIBLE);
            (adView.getPriceView() as TextView).setVisibility(View.GONE);
        } else {
            (adView.getPriceView() as TextView).setVisibility(View.GONE);
            (adView.getPriceView() as TextView).setText(nativeBannerAd.getPrice());
        }

        if (nativeBannerAd.getStore() == null) {
//            adView.getStoreView().setVisibility(View.INVISIBLE);
            (adView.getStoreView() as TextView).setVisibility(View.GONE);
        } else {
            (adView.getStoreView() as TextView).setVisibility(View.GONE);
            (adView.getStoreView() as TextView).setText(nativeBannerAd.getStore());
        }

        if (nativeBannerAd.getStarRating() == null) {
//            adView.getStarRatingView().setVisibility(View.INVISIBLE);
            (adView.getStarRatingView() as RatingBar).setVisibility(View.GONE);
        } else {
            (adView.getStarRatingView() as RatingBar)
                .setRating((nativeBannerAd.getStarRating()!!.toFloat() ));
            (adView.getStarRatingView() as RatingBar).setVisibility(View.GONE);
        }

        if (nativeBannerAd.getAdvertiser() == null) {
//            adView.getAdvertiserView().setVisibility(View.INVISIBLE);
            (adView.getAdvertiserView() as TextView).setVisibility(View.GONE);
        } else {
            (adView.getAdvertiserView() as TextView).setText(nativeBannerAd.getAdvertiser());
            (adView.getAdvertiserView() as TextView).setVisibility(View.VISIBLE);
        }


        adView.setNativeAd(nativeBannerAd);
        var vc: VideoController = nativeBannerAd.getMediaContent()!!.getVideoController();
        if (vc.hasVideoContent()) {
            vc.videoLifecycleCallbacks = object : VideoController.VideoLifecycleCallbacks() {
                override fun onVideoEnd() {
                    super.onVideoEnd()

                }
            }
        } else {
        }


        if (mideaview != null) {

            mideaview.setVisibility(View.VISIBLE)
        }

        return adView
    }
}
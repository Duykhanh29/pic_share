package com.example.pic_share
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import java.io.File
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetPlugin
import android.appwidget.AppWidgetProvider
class CustomHomeView : AppWidgetProvider() {

    // override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
    //     appWidgetIds.forEach { widgetId ->
    //         val views = RemoteViews(context.packageName, R.layout.layout_widget).apply {
    //             // ...
    //             val imagePath = widgetData.getString("filePath", null);
    //             // setImageViewBitmap(R.id.widget_image, BitmapFactory.decodeFile(imagePath))
    //             val imageFile = File(imagePath)
    //             val imageExists = imageFile.exists()
    //             if (imageExists) {
    //                 val myBitmap: Bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
    //                 setImageViewBitmap(R.id.widget_image, myBitmap)
    //             } else {
    //                 println("image not found!, looked @: $imagePath")
    //             }
    //             // setTextViewText(R.id.widget_image,"I AM KHANH")
    //         }

    //         // Update widget.
    //         appWidgetManager.updateAppWidget(widgetId, views)
    //     }
    // }
    override fun onUpdate(
       context: Context,
       appWidgetManager: AppWidgetManager,
       appWidgetIds: IntArray,
   ) {
       for (appWidgetId in appWidgetIds) {
           // Get reference to SharedPreferences
           val widgetData = HomeWidgetPlugin.getData(context)
           val views = RemoteViews(context.packageName, R.layout.layout_widget).apply {
               // Get chart image and put it in the widget, if it exists
               
               val imagePath = widgetData.getString("filePath", null)
               println("imagePath: $imagePath")
               val imageFile = File(imagePath)
               println("imageFile: $imageFile")
               val imageExists = imageFile.exists()
               println("imageExists $imageExists")
               if (imageExists) {
                  val myBitmap: Bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
                  setImageViewBitmap(R.id.widget_image, myBitmap)
               } else {
                  println("image not found!, looked @: $imagePath")
               }
               // End new code
           }
           appWidgetManager.updateAppWidget(appWidgetId, views)
       }
   }
}
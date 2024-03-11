package com.example.shared_pref

import android.app.Activity
import android.content.Context
import android.content.SharedPreferences

class SharedPrefHelper(activity: Activity) {
    private val pref: SharedPreferences =
        activity.getSharedPreferences("Name", Context.MODE_PRIVATE)


    fun getAllValues(): Map<String, *> = pref.all


    fun get(key: String): String? {
        return pref.getString(key, null)

    }

    fun set(type: String, key: String, value: Any?) = try {
        val editor = pref.edit()
        when (type) {
            "String" -> editor.putString(key, value.toString())
            "Int" -> editor.putLong(key, value.toString().toLong())
            "Float" -> editor.putFloat(key, value.toString().toFloat())
            "Boolean" -> editor.putBoolean(key, value.toString().toBoolean())
        }
        editor.apply()
        true
    } catch (e: Exception) {
        false
    }

}

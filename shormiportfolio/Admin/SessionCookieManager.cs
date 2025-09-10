using System;
using System.Web;
using System.Collections.Generic;

namespace shormiportfolio.Admin
{
    /// <summary>
    /// Utility class for managing cookies and sessions in the admin panel
    /// </summary>
    public static class SessionCookieManager
    {
        #region Cookie Management Constants
        public const string COOKIE_REMEMBER_ME = "AdminRememberMe";
        public const string COOKIE_THEME = "AdminTheme";
        public const string COOKIE_LANGUAGE = "AdminLanguage";
        public const string COOKIE_USERNAME = "SavedUsername";
        public const string COOKIE_LAST_LOGIN = "LastLoginTime";
        public const string COOKIE_LOGIN_COUNT = "LoginCount";
        public const string COOKIE_LAST_ACTIVITY = "LastActivity";
        public const string COOKIE_LAST_LOGOUT = "LastLogoutTime";
        #endregion

        #region Session Management Constants
        public const string SESSION_USERNAME = "AdminUsername";
        public const string SESSION_LOGIN_TIME = "LoginTime";
        public const string SESSION_LAST_ACTIVITY = "LastActivity";
        public const string SESSION_IS_AUTHENTICATED = "IsAuthenticated";
        public const string SESSION_AUTO_LOGGED_IN = "AutoLoggedIn";
        public const string SESSION_THEME = "CurrentTheme";
        public const string SESSION_LANGUAGE = "CurrentLanguage";
        public const string SESSION_ADMIN_LEVEL = "AdminLevel";
        public const string SESSION_LOGIN_IP = "LoginIP";
        public const string SESSION_LOGIN_BROWSER = "LoginBrowser";
        #endregion

        #region Cookie Utility Methods

        /// <summary>
        /// Create a secure cookie with specified parameters
        /// </summary>
        public static void CreateSecureCookie(string name, string value, int daysToExpire = 30, bool httpOnly = true)
        {
            try
            {
                HttpCookie cookie = new HttpCookie(name, value);
                cookie.Expires = DateTime.Now.AddDays(daysToExpire);
                cookie.HttpOnly = httpOnly; // Security: prevent XSS
                cookie.Secure = HttpContext.Current.Request.IsSecureConnection; // Security: HTTPS only if available
                cookie.Path = "/";
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error creating cookie {name}: {ex.Message}");
            }
        }

        /// <summary>
        /// Get cookie value with optional default
        /// </summary>
        public static string GetCookieValue(string cookieName, string defaultValue = "")
        {
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];
                return cookie?.Value ?? defaultValue;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error reading cookie {cookieName}: {ex.Message}");
                return defaultValue;
            }
        }

        /// <summary>
        /// Clear/delete a cookie
        /// </summary>
        public static void ClearCookie(string cookieName)
        {
            try
            {
                HttpCookie cookie = new HttpCookie(cookieName);
                cookie.Expires = DateTime.Now.AddDays(-1);
                cookie.Value = "";
                cookie.Path = "/";
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error clearing cookie {cookieName}: {ex.Message}");
            }
        }

        /// <summary>
        /// Check if a cookie exists
        /// </summary>
        public static bool CookieExists(string cookieName)
        {
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];
                return cookie != null && !string.IsNullOrEmpty(cookie.Value);
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Clear all admin-related cookies
        /// </summary>
        public static void ClearAllAdminCookies()
        {
            string[] adminCookies = {
                COOKIE_REMEMBER_ME,
                COOKIE_THEME,
                COOKIE_LANGUAGE,
                COOKIE_USERNAME,
                COOKIE_LAST_LOGIN,
                COOKIE_LOGIN_COUNT,
                COOKIE_LAST_ACTIVITY,
                COOKIE_LAST_LOGOUT
            };

            foreach (string cookieName in adminCookies)
            {
                ClearCookie(cookieName);
            }
        }

        #endregion

        #region Session Utility Methods

        /// <summary>
        /// Set a session value
        /// </summary>
        public static void SetSessionValue(string key, object value)
        {
            try
            {
                HttpContext.Current.Session[key] = value;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error setting session value {key}: {ex.Message}");
            }
        }

        /// <summary>
        /// Get session value with type casting
        /// </summary>
        public static T GetSessionValue<T>(string key, T defaultValue = default(T))
        {
            try
            {
                object sessionValue = HttpContext.Current.Session[key];
                if (sessionValue != null)
                {
                    return (T)sessionValue;
                }
                return defaultValue;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting session value {key}: {ex.Message}");
                return defaultValue;
            }
        }

        /// <summary>
        /// Check if session key exists
        /// </summary>
        public static bool SessionKeyExists(string key)
        {
            try
            {
                return HttpContext.Current.Session[key] != null;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Remove a session key
        /// </summary>
        public static void RemoveSessionKey(string key)
        {
            try
            {
                HttpContext.Current.Session.Remove(key);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error removing session key {key}: {ex.Message}");
            }
        }

        /// <summary>
        /// Get current session information as a dictionary
        /// </summary>
        public static Dictionary<string, object> GetSessionInfo()
        {
            var sessionInfo = new Dictionary<string, object>();
            try
            {
                sessionInfo.Add("SessionID", HttpContext.Current.Session.SessionID);
                sessionInfo.Add("IsNewSession", HttpContext.Current.Session.IsNewSession);
                sessionInfo.Add("Timeout", HttpContext.Current.Session.Timeout);
                sessionInfo.Add("Count", HttpContext.Current.Session.Count);
                
                // Add specific admin session values
                if (SessionKeyExists(SESSION_USERNAME))
                    sessionInfo.Add("Username", GetSessionValue<string>(SESSION_USERNAME));
                
                if (SessionKeyExists(SESSION_LOGIN_TIME))
                    sessionInfo.Add("LoginTime", GetSessionValue<DateTime>(SESSION_LOGIN_TIME));
                
                if (SessionKeyExists(SESSION_LAST_ACTIVITY))
                    sessionInfo.Add("LastActivity", GetSessionValue<DateTime>(SESSION_LAST_ACTIVITY));
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting session info: {ex.Message}");
            }
            return sessionInfo;
        }

        #endregion

        #region User Preference Management

        /// <summary>
        /// Save user preferences to cookies
        /// </summary>
        public static void SaveUserPreferences(string theme = "Dark", string language = "en-US")
        {
            CreateSecureCookie(COOKIE_THEME, theme, 30);
            CreateSecureCookie(COOKIE_LANGUAGE, language, 30);
        }

        /// <summary>
        /// Load user preferences from cookies
        /// </summary>
        public static UserPreferences LoadUserPreferences()
        {
            return new UserPreferences
            {
                Theme = GetCookieValue(COOKIE_THEME, "Dark"),
                Language = GetCookieValue(COOKIE_LANGUAGE, "en-US"),
                SavedUsername = GetCookieValue(COOKIE_USERNAME, ""),
                LastLoginTime = GetCookieValue(COOKIE_LAST_LOGIN, ""),
                LoginCount = int.TryParse(GetCookieValue(COOKIE_LOGIN_COUNT, "0"), out int count) ? count : 0
            };
        }

        /// <summary>
        /// Update activity timestamp in both session and cookie
        /// </summary>
        public static void UpdateActivity()
        {
            DateTime now = DateTime.Now;
            SetSessionValue(SESSION_LAST_ACTIVITY, now);
            CreateSecureCookie(COOKIE_LAST_ACTIVITY, now.ToString("yyyy-MM-dd HH:mm:ss"), 1);
        }

        #endregion

        #region Security Helpers

        /// <summary>
        /// Check if session is expired based on last activity
        /// </summary>
        public static bool IsSessionExpired(int timeoutMinutes = 30)
        {
            try
            {
                DateTime lastActivity = GetSessionValue<DateTime>(SESSION_LAST_ACTIVITY);
                if (lastActivity == default(DateTime))
                    return true;

                return DateTime.Now.Subtract(lastActivity).TotalMinutes > timeoutMinutes;
            }
            catch
            {
                return true;
            }
        }

        /// <summary>
        /// Get user's security information
        /// </summary>
        public static UserSecurityInfo GetUserSecurityInfo()
        {
            try
            {
                return new UserSecurityInfo
                {
                    IPAddress = HttpContext.Current.Request.UserHostAddress,
                    UserAgent = HttpContext.Current.Request.UserAgent,
                    Browser = HttpContext.Current.Request.Browser.Browser,
                    Platform = HttpContext.Current.Request.Browser.Platform,
                    IsSecureConnection = HttpContext.Current.Request.IsSecureConnection,
                    SessionID = HttpContext.Current.Session.SessionID
                };
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting security info: {ex.Message}");
                return new UserSecurityInfo();
            }
        }

        #endregion
    }

    #region Helper Classes

    /// <summary>
    /// User preferences data structure
    /// </summary>
    public class UserPreferences
    {
        public string Theme { get; set; } = "Dark";
        public string Language { get; set; } = "en-US";
        public string SavedUsername { get; set; } = "";
        public string LastLoginTime { get; set; } = "";
        public int LoginCount { get; set; } = 0;
    }

    /// <summary>
    /// User security information data structure
    /// </summary>
    public class UserSecurityInfo
    {
        public string IPAddress { get; set; } = "";
        public string UserAgent { get; set; } = "";
        public string Browser { get; set; } = "";
        public string Platform { get; set; } = "";
        public bool IsSecureConnection { get; set; } = false;
        public string SessionID { get; set; } = "";
    }

    #endregion
}
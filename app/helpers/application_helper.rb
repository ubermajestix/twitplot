# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def advertising
    adbrite = <<-ADS
      <!-- Begin: AdBrite, Generated: 2009-01-14 12:04:22  -->
      <script type="text/javascript">
      var AdBrite_Title_Color = '3D81EE';
      var AdBrite_Text_Color = '333333';
      var AdBrite_Background_Color = 'FFFFFF';
      var AdBrite_Border_Color = 'FFFFFF';
      var AdBrite_URL_Color = '3D81EE';
      try{var AdBrite_Iframe=window.top!=window.self?2:1;var AdBrite_Referrer=document.referrer==''?document.location:document.referrer;AdBrite_Referrer=encodeURIComponent(AdBrite_Referrer);}catch(e){var AdBrite_Iframe='';var AdBrite_Referrer='';}
      </script>
      <span style="white-space:nowrap;"><script type="text/javascript">document.write(String.fromCharCode(60,83,67,82,73,80,84));document.write(' src="http://ads.adbrite.com/mb/text_group.php?sid=999736&zs=3732385f3930&ifr='+AdBrite_Iframe+'&ref='+AdBrite_Referrer+'" type="text/javascript">');document.write(String.fromCharCode(60,47,83,67,82,73,80,84,62));</script>
      <a target="_top" href="http://www.adbrite.com/mb/commerce/purchase_form.php?opid=999736&afsid=1"><img src="http://files.adbrite.com/mb/images/adbrite-your-ad-here-leaderboard.gif" style="background-color:#FFFFFF;border:none;padding:0;margin:0;" alt="Your Ad Here" width="14" height="90" border="0" /></a></span>
      <!-- End: AdBrite -->
    ADS
    return adbrite
  end
  
end

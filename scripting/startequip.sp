#include <sourcemod>
#include <sdktools>

#undef REQUIRE_PLUGIN
#include <updater>

#define UPDATE_URL		"http://bitbucket.toastdev.de/sourcemod-plugins/raw/master/StartEquip.txt"

public Plugin:myinfo = 
{
	name = "Start Equip",
	author = "Toast",
	description = "Give CT's some start equipment",
	version = "1.0.0",
	url = "bitbucket.toastdev.de"
}

public OnPluginStart()
{
	HookEvent("player_spawn", PlayerSpawn);
}

public OnLibraryAdded(const String:name[])
{
    if (StrEqual(name, "updater"))
    {
        Updater_AddPlugin(UPDATE_URL)
    }
}

public APLRes:AskPluginLoad2(Handle:myself, bool:late, String:error[], err_max)
{
   MarkNativeAsOptional("Updater_AddPlugin");
   return APLRes_Success;
}

public PlayerSpawn(Handle:event, const String:name[], bool:dontBroadcast)
{
	new p_iUserid;
	userid = GetEventInt(event, "userid");
	new p_iClient;
	p_iClient = GetClientOfUserId(p_iUserid);

	if(IsClientInGame(p_iClient) && IsPlayerAlive(p_iClient) && GetClientTeam(p_iClient) == 3)
	{
		SetEntProp(p_iClient, Prop_Send, "m_ArmorValue", 100);
		SetEntProp(p_iClient, Prop_Send, "m_bHasHelmet", 1);
	}
}

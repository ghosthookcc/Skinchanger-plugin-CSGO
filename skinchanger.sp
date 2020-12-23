#pragma semicolon 1

#define PLUGIN_AUTHOR "JustCrypticsuxj"
#define PLUGIN_VERSION "1.0.0"

#include <sourcemod>
#include <sdktools>

#pragma newdecls required

public Plugin myinfo = 
{
	name = "A test",
	author = PLUGIN_AUTHOR,
	description = "Test, weapon skin change...",
	version = PLUGIN_VERSION,
	url = ""
};

void changeSkin(int client, char[] weaponName, int skinID) 
{	
	int currWeapon = GetEntPropEnt(client, Prop_Data, "m_hActiveWeapon");
	
	int WeaponEntity;
	for (int i = 0; i < 3; i++) 
	{	 
		if((WeaponEntity = GetPlayerWeaponSlot(client, i)) == currWeapon) 
		{		
			RemovePlayerItem(client, WeaponEntity);
			AcceptEntityInput(WeaponEntity, "Kill");  
		
			int entity = GivePlayerItem(client, weaponName);
			GetEntProp(entity, Prop_Send, "m_iItemIDLow");

			SetEntProp(entity, Prop_Send, "m_iItemIDLow", 2048);
   			SetEntProp(entity, Prop_Send, "m_nFallbackPaintKit", skinID);   
		}	 
	}
}

public void OnPluginStart()
{
	RegConsoleCmd("sm_reskin", give_weapon);
}

public Action give_weapon(int client, int args) 
{	
	int skinID = 38;
	char weapon[128];
		
	GetClientWeapon(client, weapon, sizeof(weapon));
	changeSkin(client, weapon, skinID);
}



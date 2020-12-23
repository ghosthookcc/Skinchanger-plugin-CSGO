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
	for (int i = 0; i < 5; i++) 
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
	LoadTranslations("menu_translations.phrases");
	
	RegConsoleCmd("sm_menu", hMenuCallback);
	// RegConsoleCmd("sm_reskin", command_reskin);
}

public Action hMenuCallback(int client, int args)  
{
	Menu hMenu = new Menu(manage_menu, MENU_ACTIONS_ALL);
	
	hMenu.SetTitle("%T", "Menu Title", LANG_SERVER);

	hMenu.AddItem("38", "Fade");
	hMenu.AddItem("37", "Blaze");
	hMenu.AddItem("353", "Water Elemental");
	
	hMenu.ExitButton = true;
	hMenu.Display(client, 20);
	
	return Plugin_Handled;
}

public int manage_menu(Menu menu, MenuAction menuEvent, int param1, int param2) 
{
	switch(menuEvent) 
	{
		// (nothing passed)
		case MenuAction_Start:
		{
			PrintToServer("Displaying menu...");
		}
		
		// (param1=client, param2=MenuPanel Handle)
		case MenuAction_Display: 
		{

		}
		
		// An item was selected (param1=client, param2=item)
		case MenuAction_Select: 
		{
			char item[64];
			menu.GetItem(param2, item, sizeof(item));
			
			PrintToChatAll("%d selected %s", param1, item);
			
			int skinID = StringToInt(item, 10);
			char weapon[128];
		
			GetClientWeapon(param1, weapon, sizeof(weapon));
			changeSkin(param1, weapon, skinID);
		}
		
		// The menu was cancelled (param1=client, param2=reason)
		case MenuAction_Cancel:
		{
			
		}
		
		// (VOTE ONLY): A vote sequence has succeeded (param1=chosen item) This is not called if SetVoteResultCallback has been used on the menu.
		case MenuAction_VoteStart: 
		{
			
		}
		
		// (VOTE ONLY): A vote sequence has been cancelled (param1=reason)
		case MenuAction_VoteCancel:
		{
			
		}
		
		// A menu display has fully ended. param1 is the MenuEnd reason, and if it's MenuEnd_Cancelled, then param2 is the MenuCancel reason from MenuAction_Cancel.
		case MenuAction_VoteEnd:
		{
			
		}
		
		// An item is being drawn; return the new style (param1=client, param2=item)
		case MenuAction_DrawItem:
		{
			
		}
		
		// (nothing passed)
		case MenuAction_DisplayItem:	
		{
			
		}
		
		// (nothing passed)
		case MenuAction_End: 
		{
			delete menu;
		}
	}
}

// Copyright 2018, Earthfiredrake
// Released under the terms of the MIT License
// https://github.com/Earthfiredrake/SWL-GlitterGone

// Makes shiny agents look like basic ones
// Minimod, not framework enabled for now

import gfx.utils.Delegate;
import com.GameInterface.DistributedValue;

function onLoad():Void { 
	AgentWindow = DistributedValue.Create("agentSystem_window");
	AgentWindow.SignalChanged.Connect(HookUI, this);
}

function HookUI(dv:DistributedValue):Void {
	if (AgentWindow.GetValue() && !_global.GUI.AgentSystem.RosterIcon.prototype.efdGG_UpdateVisualsBase) {
		if (_global.GUI.AgentSystem.RosterIcon.prototype) {
			_global.GUI.AgentSystem.RosterIcon.prototype.efdGG_UpdateVisualsBase = _global.GUI.AgentSystem.RosterIcon.prototype.UpdateVisuals;
			_global.GUI.AgentSystem.RosterIcon.prototype.UpdateVisuals = function() {
				this.efdGG_UpdateVisualsBase();
				this.m_Foil._visible = false;
				this.m_Foil.gotoAndStop(1);
			};
		} else { setTimeout(Delegate.create(this, HookUI), 50, dv); }
	}
}

var AgentWindow:DistributedValue;

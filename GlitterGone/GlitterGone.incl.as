// Copyright 2018, Earthfiredrake
// Released under the terms of the MIT License
// https://github.com/Earthfiredrake/SWL-GlitterGone

// Makes shiny agents look like basic ones
// Minimod, not framework enabled for now

import gfx.utils.Delegate;
import com.GameInterface.DistributedValue;

function onLoad():Void {
	// HACK: Faking static storage, to avoid needing a class file
	if (_global.efd == undefined) { _global.efd = new Object(); }
	if (_global.efd.GlitterGone == undefined) { _global.efd.GlitterGone = new Object(); }

	AgentWindow = DistributedValue.Create("agentSystem_window");
	AgentWindow.SignalChanged.Connect(HookUI, this);
	HookUI(AgentWindow);
}

function HookUI(dv:DistributedValue):Void {
	if (!_global.efd.GlitterGone.HookApplied) {
		var proto:Object = _global.GUI.AgentSystem.RosterIcon.prototype;
		if (proto) {
			var wrapper:Function = function() {
				arguments.callee.base.apply(this, arguments);
				this.m_Foil._visible = false;
				this.m_Foil.gotoAndStop(1);
			};
			wrapper.base = proto.UpdateVisuals;
			proto.UpdateVisuals = wrapper;
			_global.efd.GlitterGone.HookApplied = true;
		} else if (dv.GetValue()) { // Window has been opened, will have a prototype soon
			setTimeout(Delegate.create(this, HookUI), 50, dv);
		}
	}
}

var AgentWindow:DistributedValue;

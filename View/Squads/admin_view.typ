<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Squads"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["Squads"]["name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
		<div class="panel-heading">
			<?php echo $this->Html->__t("Squads view"); ?>
			<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["Squads"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["Squads"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
			</span>
		</div>
		<div class="panel-body">
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Name"); ?></span>
				<span class="col-md-9"><?php echo $typ__["data"]["Squads"]["name"]; ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Army"); ?></span>
				<span class="col-md-9">
					<?php echo $this->Html->Url($typ__["data"]["Squads"]["army_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($typ__["data"]["Squads"]["army_id"]))); ?>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Type"); ?></span>
				<span class="col-md-9">
					<?php echo $this->Html->Url($typ__["data"]["Squads"]["type_name"], array("controller" => "types", "action" => "view", "admin" => true, "params" => array($typ__["data"]["Squads"]["type_id"]))); ?>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Squads"]["created"]); ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Squads"]["modified"]); ?></span>
			</div>
		</div>
	</div>
</div>



<?php
if(isset($typ__["data"]["Squads"]["SquadUnits"])) {
	foreach($typ__["data"]["Squads"]["SquadUnits"] as $squadunit) {
		$panel = "panel-success";
		if(!isset($squadunit["min_count"]) && !isset($squadunit["max_count"]))
		$panel = "panel-danger";
?>
<div class="raceTypes view">
	<div class="panel <?php echo $panel; ?>">
		<div class="panel-heading">
			<?php echo $this->Html->__t("Squad Unit information"); ?> - <?php echo $squadunit['name'];?>
			<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "squadunits", "action" => "edit", "admin" => true, "params" => array($squadunit["id"], $typ__["data"]["Squads"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "controller" => "squadunits", "action" => "delete", "params" => array($squadunit["id"], $typ__["data"]["Squads"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
			</span>
		</div>

				<table class="table table-striped table-bordered table-listings">
					<tr>
						<th><?php echo $this->Html->__t('Name'); ?></th>
						<?php
						if($squadunit['Units']['front_armour'] == 0) {
						?>
						<th><?php echo $this->Html->__t('WS'); ?></th>
						<th><?php echo $this->Html->__t('BS'); ?></th>
						<th><?php echo $this->Html->__t('S'); ?></th>
						<th><?php echo $this->Html->__t('T'); ?></th>
						<th><?php echo $this->Html->__t('I'); ?></th>
						<th><?php echo $this->Html->__t('W'); ?></th>
						<th><?php echo $this->Html->__t('A'); ?></th>
						<th><?php echo $this->Html->__t('Ld'); ?></th>
						<th><?php echo $this->Html->__t('S'); ?></th>
						<th><?php echo $this->Html->__t('Is'); ?></th>
						<!--th><?php //echo $this->Html->__t('Pts'); ?></th-->
						<?php
						} else {
						?>
						<th><?php echo $this->Html->__t('WS'); ?></th>
						<th><?php echo $this->Html->__t('BS'); ?></th>
						<th><?php echo $this->Html->__t('S'); ?></th>
						<th><?php echo $this->Html->__t('FA'); ?></th>
						<th><?php echo $this->Html->__t('SA'); ?></th>
						<th><?php echo $this->Html->__t('RA'); ?></th>
						<th><?php echo $this->Html->__t('I'); ?></th>
						<th><?php echo $this->Html->__t('A'); ?></th>
						<th><?php echo $this->Html->__t('HP'); ?></th>
						<!--th><?php //echo $this->Html->__t('Pts'); ?></th-->
						<?php
						}
						?>

						<th><?php echo $this->Html->__t('Created'); ?></th>
						<th><?php echo $this->Html->__t('Modified'); ?></th>
						<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
					</tr>

					<tr>
						<td><?php echo $squadunit['name'];?></td>
						<?php
						if($squadunit['Units']['front_armour'] == 0) {
						?>
						<td><?php echo $squadunit['Units']['weapon_skill'];?></td>
						<td><?php echo $squadunit['Units']['ballistic_skill'];?></td>
						<td><?php echo $squadunit['Units']['strength'];?></td>
						<td><?php echo $squadunit['Units']['toughness'];?></td>
						<td><?php echo $squadunit['Units']['initiative'];?></td>
						<td><?php echo $squadunit['Units']['wounds'];?></td>
						<td><?php echo $squadunit['Units']['attacks'];?></td>
						<td><?php echo $squadunit['Units']['leadership'];?></td>
						<td><?php echo $squadunit['Units']['armour_save'];?></td>
						<td><?php echo $squadunit['Units']['invulnerable_save'];?></td>
						<!--td><?php //echo $squadunit['Units']['pts'];?></td-->
						<?php
						} else {
						?>
						<td><?php echo $squadunit['Units']['weapon_skill'];?></td>
						<td><?php echo $squadunit['Units']['ballistic_skill'];?></td>
						<td><?php echo $squadunit['Units']['strength'];?></td>
						<td><?php echo $squadunit['Units']['front_armour'];?></td>
						<td><?php echo $squadunit['Units']['side_armour'];?></td>
						<td><?php echo $squadunit['Units']['rear_armour'];?></td>
						<td><?php echo $squadunit['Units']['initiative'];?></td>
						<td><?php echo $squadunit['Units']['attacks'];?></td>
						<td><?php echo $squadunit['Units']['hull_hitpoints'];?></td>
						<!--td><?php //echo $squadunit['Units']['pts'];?></td-->
						<?php
						}
						?>

						<td><?php echo $this->Html->Time("TimeAgo", $squadunit['Units']['created']);?></td>
						<td><?php echo $this->Html->Time("TimeAgo", $squadunit['Units']['modified']);?></td>
						<td class="actions">
							<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'units', 'action' => 'view', "params" => array($squadunit['Units']['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
							<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'units', 'action' => 'edit', "params" => array($squadunit['Units']['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
							<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'units', 'action' => 'delete', "params" => array($squadunit['Units']['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
						</td>
					</tr>
				</table>

		<div class="panel-body">

			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Wargear"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["Wargears"])) {

						foreach($squadunit["Wargears"] as $wargear) {?>
							<li class="list-group-item"><?php echo $wargear["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "wargears", "action" => "edit", "admin" => true, "params" => array($wargear['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php } ?>
					<?php } else {
						?>
						<li class="list-group-item">None</li>
						<?php
					}
					?>
					</ul>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Unit Characteristics"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["UnitCharacteristics"])) {
						foreach($squadunit["UnitCharacteristics"] as $uc) {?>
							<li class="list-group-item"><?php echo $uc["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "UnitCharacteristics", "action" => "edit", "admin" => true, "params" => array($uc['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php }
						} else {
							?>
							<li class="list-group-item">None</li>
							<?php
						}
					?>
					</ul>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Psyker abilities"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["Psykers"])) {
						foreach($squadunit["Psykers"] as $py) {?>
							<li class="list-group-item"><?php echo $py["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "psykers", "action" => "edit", "admin" => true, "params" => array($py['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php }
						} else {
							?>
							<li class="list-group-item">None</li>
							<?php
						}
					?>
					</ul>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Race relics"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["Relics"])) {
						foreach($squadunit["Relics"] as $rr) {?>
							<li class="list-group-item"><?php echo $rr["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "psykers", "action" => "edit", "admin" => true, "params" => array($rr['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php }
						} else {
							?>
							<li class="list-group-item">None</li>
							<?php
						}
					?>
					</ul>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Warlord traits"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["Warlords"])) {
						foreach($squadunit["Warlords"] as $wt) {?>
							<li class="list-group-item"><?php echo $wt["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "psykers", "action" => "edit", "admin" => true, "params" => array($wt['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php }
						} else {
							?>
							<li class="list-group-item">None</li>
							<?php
						}
					?>
					</ul>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Transport capacity"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["Transports"])) {
						foreach($squadunit["Transports"] as $tc) {?>
							<li class="list-group-item"><?php echo $tc["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "psykers", "action" => "edit", "admin" => true, "params" => array($tc['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php }
						} else {
							?>
							<li class="list-group-item">None</li>
							<?php
						}
					?>
					</ul>
				</span>
			</div>
			<?php if(isset($squadunit["Groups"])) { ?>
				<div class="row">
					<span class="col-md-3"><?php echo $this->Html->__t("Unit Upgrades"); ?></span>
					<span class="col-md-9">
						<?php

							foreach($squadunit["Groups"] as $groups) {
									$list = " list-group-item-success";
									if(!isset($groups["min_count"]) && !isset($groups["max_count"])) {
										$list = " list-group-item-danger";
									}
								?>
								<ul class="list-group">
									<li class="list-group-item<?php echo $list;?>"><?php echo $groups["name"]; ?>: Min <?php echo $groups["min_count"]; ?> - Max <?php echo $groups["max_count"]; ?>

										<span class="pull-right">
											<?php echo $this->Html->Url($this->Html->__t("View"), array("controller" => "groups", "action" => "view", "admin" => true, "params" => array($groups["id"])), array("class" => "btn-sm btn-primary")); ?>
											<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "unitgroups", "action" => "edit", "admin" => true, "params" => array($groups["unitgroups_id"], $typ__["data"]["Squads"]["id"])), array("class" => "btn-sm btn-warning")); ?>
											<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "controller" => "unitgroups", "action" => "delete", "params" => array($groups["unitgroups_id"], $typ__["data"]["Squads"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
										</span>
									</li>
								</ul>
							<?php }
						?>
					</span>
				</div>
			<?php }
			?>

			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Min Squad count"); ?></span>
				<span class="col-md-9"><?php echo $squadunit["min_count"]; ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Max Squad count"); ?></span>
				<span class="col-md-9"><?php echo $squadunit["max_count"]; ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Unit type"); ?></span>
				<span class="col-md-9"><?php echo $squadunit["Units"]["unittype"]; ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $squadunit["created"]); ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $squadunit["modified"]); ?></span>
			</div>
		</div>
	</div>
</div>
<?php
	}
}
?>

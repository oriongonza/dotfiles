#!/usr/bin/env python3

"""
Improved CPU Governor Script for Waybar
Displays current CPU governor with appropriate icons and tooltips
"""

import json
import logging
import os
import sys
from datetime import datetime
from pathlib import Path
from typing import Optional, Dict, Any


class CPUGovernorMonitor:
    """Monitor and display CPU governor information for Waybar"""
    
    def __init__(self):
        self.home = Path.home()
        self.log_file = self.home / ".config/waybar/cpugovernor.log"
        self.prev_gov_file = self.home / ".cache/prev_governor.txt"
        self.governor_file = Path("/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor")
        
        # Governor configurations with icons and display names
        self.governor_config = {
            'performance': {
                'icon': '󱐋',
                'class': 'performance',
                'name': 'Performance'
            },
            'powersave': {
                'icon': '',
                'class': 'powersave',
                'name': 'Powersave'
            },
            'ondemand': {
                'icon': '',
                'class': 'balanced',
                'name': 'OnDemand'
            },
            'conservative': {
                'icon': '',
                'class': 'balanced',
                'name': 'Conservative'
            },
            'schedutil': {
                'icon': '',
                'class': 'balanced',
                'name': 'Schedutil'
            },
            'balanced': {
                'icon': '',
                'class': 'balanced',
                'name': 'Balanced'
            },
            'userspace': {
                'icon': '󰍛',
                'class': 'userspace',
                'name': 'Userspace'
            }
        }
        
        self._setup_logging()
    
    def _setup_logging(self) -> None:
        """Setup logging configuration"""
        self.log_file.parent.mkdir(parents=True, exist_ok=True)
        
        logging.basicConfig(
            filename=self.log_file,
            level=logging.INFO,
            format='[%(asctime)s] [%(levelname)s] %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        self.logger = logging.getLogger(__name__)
    
    def _safe_read_file(self, file_path: Path, default: str = "") -> str:
        """Safely read file content with error handling"""
        try:
            if file_path.exists() and file_path.is_file():
                return file_path.read_text().strip()
        except (OSError, IOError, PermissionError) as e:
            self.logger.warning(f"Failed to read {file_path}: {e}")
        return default
    
    def _safe_write_file(self, file_path: Path, content: str) -> bool:
        """Safely write content to file"""
        try:
            file_path.parent.mkdir(parents=True, exist_ok=True)
            file_path.write_text(content)
            return True
        except (OSError, IOError, PermissionError) as e:
            self.logger.error(f"Failed to write to {file_path}: {e}")
            return False
    
    def _get_cpu_freq_info(self) -> str:
        """Get CPU frequency information for tooltip"""
        freq_paths = {
            'min': Path("/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq"),
            'max': Path("/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq"),
            'cur': Path("/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq")
        }
        
        freq_info = {}
        for key, path in freq_paths.items():
            freq_khz = self._safe_read_file(path, "0")
            try:
                freq_mhz = int(freq_khz) // 1000
                freq_info[key] = f"{freq_mhz}MHz"
            except (ValueError, TypeError):
                freq_info[key] = "N/A"
        
        return f"Current: {freq_info['cur']} | Range: {freq_info['min']}-{freq_info['max']}"
    
    def _create_waybar_output(self, governor: str) -> Dict[str, Any]:
        """Create Waybar JSON output"""
        config = self.governor_config.get(governor)
        
        if config is None:
            # Handle unknown governor
            self.logger.warning(f"Unknown governor: {governor}")
            config = {
                'icon': '󰀪',
                'class': 'unknown',
                'name': f'Unknown ({governor})'
            }
        
        freq_info = self._get_cpu_freq_info()
        tooltip = f"Governor: {config['name']}\\nFrequency: {freq_info}"
        
        return {
            'text': config['icon'],
            'class': config['class'],
            'tooltip': tooltip
        }
    
    def _check_governor_change(self, current: str, previous: str) -> None:
        """Log governor changes"""
        if current != previous and previous:
            self.logger.info(f"Governor changed: {previous} -> {current}")
    
    def run(self) -> None:
        """Main execution function"""
        try:
            # Check if governor file exists and is readable
            if not self.governor_file.exists():
                self.logger.error(f"Governor file not found: {self.governor_file}")
                output = {
                    'text': '󰀪',
                    'class': 'error',
                    'tooltip': 'Error: Governor file not accessible'
                }
                print(json.dumps(output))
                sys.exit(1)
            
            # Read current governor
            current_governor = self._safe_read_file(self.governor_file, "unknown")
            if not current_governor:
                self.logger.error("Failed to read current governor")
                current_governor = "unknown"
            
            # Read previous governor
            previous_governor = self._safe_read_file(self.prev_gov_file)
            
            # Check for changes and log
            self._check_governor_change(current_governor, previous_governor)
            
            # Save current governor for next run
            self._safe_write_file(self.prev_gov_file, current_governor)
            
            # Create and output Waybar JSON
            output = self._create_waybar_output(current_governor)
            print(json.dumps(output))
            
        except KeyboardInterrupt:
            self.logger.info("Script interrupted by user")
            sys.exit(0)
        except Exception as e:
            self.logger.error(f"Unexpected error: {e}")
            error_output = {
                'text': '󰀪',
                'class': 'error',
                'tooltip': f'Error: {str(e)}'
            }
            print(json.dumps(error_output))
            sys.exit(1)


def main():
    """Entry point"""
    monitor = CPUGovernorMonitor()
    monitor.run()


if __name__ == "__main__":
    main()
